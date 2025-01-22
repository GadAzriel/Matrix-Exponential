import Prelude hiding ((<>))
import Numeric.LinearAlgebra

-- Identity Matrix
identityMatrix :: Int -> Matrix Double
identityMatrix n = ident n

-- Divide Matrix by Scalar
divideMatrixByScalar :: Matrix Double -> Double -> Matrix Double
divideMatrixByScalar m scalar = scale (1 / scalar) m

-- Add Two Matrices
addMatrices :: Matrix Double -> Matrix Double -> Matrix Double
addMatrices = (+)

-- Max Norm (Infinity Norm)
maxNorm :: Matrix Double -> Double
maxNorm m = maximum $ toList $ cmap abs $ m #> vectorOfOnes
  where
    vectorOfOnes = konst 1 (cols m)

-- Compute the Matrix Exponential using Power Series
matrixExponential :: Matrix Double -> Double -> Matrix Double
matrixExponential m epsilon = computeExponential (identityMatrix n) (identityMatrix n) 1
  where
    n = rows m
    computeExponential result term k =
      let term' = divideMatrixByScalar (term <> m) k
          result' = addMatrices result term'
          nextTermNorm = maxNorm (term' <> m) / (k + 1)
       in if nextTermNorm < epsilon
            then result'
            else computeExponential result' term' (k + 1)

-- Scaling and Squaring Method for Matrix Exponential
scaleAndSquareExponential :: Matrix Double -> Double -> Matrix Double
scaleAndSquareExponential m epsilon =
  let maxNormValue = maxNorm m
      s = max 0 (ceiling (logBase 2 maxNormValue))
      scaledM = divideMatrixByScalar m (2 ^^ s)
      eMScaled = matrixExponential scaledM epsilon
   in foldl (\acc _ -> acc <> acc) eMScaled [1 .. s]

-- Read Matrix from File
readMatrixFromFile :: FilePath -> IO (Maybe (Matrix Double))
readMatrixFromFile path = do
  content <- readFile path
  let matrixLines = lines content
  let parsedMatrix = map (map read . words) matrixLines
  let matrix = fromLists parsedMatrix
  if rows matrix /= cols matrix
    then return Nothing
    else return (Just matrix)

main :: IO ()
main = do
  let epsilon = 1e-6
  let filePath = "exp_data.txt"
  maybeMatrix <- readMatrixFromFile filePath
  case maybeMatrix of
    Nothing -> putStrLn "Invalid matrix or file not found."
    Just matrix -> do
      putStrLn "Computing matrix exponential using Scaling and Squaring Method..."
      let eM = scaleAndSquareExponential matrix epsilon
      -- Print only the first value (top-left element of the matrix)
      putStrLn $ "First value of the result: " ++ show (eM `atIndex` (0, 0))

