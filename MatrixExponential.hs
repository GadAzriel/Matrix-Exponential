import Numeric.LinearAlgebra
import Prelude hiding ((<>))
import Data.Time.Clock (getCurrentTime, diffUTCTime)

-- Factorial function
factorial :: Int -> Int -> Int
factorial 0 acc = acc
factorial x acc = factorial (x - 1) (acc * x)

-- Lagrange remainder calculation
lagrangeRemainder :: Matrix Double -> Int -> Double
lagrangeRemainder mat n =
  let matNorm = matrixNorm mat 
      remainder = (exp matNorm / fromIntegral (factorial (n + 1) 1)) * (matNorm ^^ (n + 1))
  in remainder

-- Scaling down the matrix
scaleDownMatrix :: Matrix Double -> Matrix Double
scaleDownMatrix mat = mat * 0.5

-- Function to calculate the norm of a matrix
matrixNorm :: Matrix Double -> Double
matrixNorm mat = sqrt . sumElements $ mat * mat

-- Scale matrix recursively to reduce its norm below 2
scaleMatrix :: Matrix Double -> Int -> (Matrix Double, Int)
scaleMatrix mat scalingFactor
  | matrixNorm mat <= 2 = (mat, scalingFactor)
  | otherwise = scaleMatrix (scaleDownMatrix mat) (scalingFactor + 1)

-- Compute the next term in the Taylor series
computeNextTerm :: Matrix Double -> Matrix Double -> Int -> Matrix Double
computeNextTerm lastTerm mat n = (lastTerm <> mat) * (1 / fromIntegral n)

-- Scaling the matrix back up
scalingBackMatrix :: Matrix Double -> Int -> Matrix Double
scalingBackMatrix mat 0 = mat
--                                                     Check the multi
scalingBackMatrix mat scalingFactor = scalingBackMatrix (mat <> mat) (scalingFactor - 1)

-- Single step of the Taylor series calculation
taylorSeriesStep :: Matrix Double -> Matrix Double -> Matrix Double -> Int -> (Matrix Double, Matrix Double)
taylorSeriesStep mat eA lastTerm n =
  let nextTerm = computeNextTerm lastTerm mat n
      newEA = eA + nextTerm
  in (newEA, nextTerm)

-- Full Taylor series calculation
taylorSeries :: Matrix Double -> Matrix Double -> Matrix Double -> Int -> Double -> Matrix Double
taylorSeries mat eA lastTerm n epsilon =
  let (updatedEA, nextTerm) = taylorSeriesStep mat eA lastTerm n
      remainder = lagrangeRemainder mat n
  in if remainder < epsilon
       then updatedEA 
       else taylorSeries mat updatedEA nextTerm (n + 1) epsilon

-- Matrix exponential calculation
matrixExponential :: Matrix Double -> Double -> Matrix Double
matrixExponential mat epsilon =
  let (scaledMat, scalingFactor) = scaleMatrix mat 0
      identityMatrix = ident (rows mat)
      eA = taylorSeries scaledMat identityMatrix identityMatrix 1 epsilon
  in scalingBackMatrix eA scalingFactor

-- Reading data from a file without handling commas
readData :: FilePath -> IO (Matrix Double)
readData path = do
  content <- readFile path
  let rows = map (map read . words) $ lines content
  return $ fromLists rows

-- Main function
main :: IO ()
main = do
  let path = "exp_data.txt"
      epsilon = 1e-6

  -- Read matrix data
  mat <- readData path

  -- Custom implementation
  startTime <- getCurrentTime
  let result = matrixExponential mat epsilon
  endTime <- getCurrentTime
  putStrLn $ "Time for our implementation: " ++ show (realToFrac (diffUTCTime endTime startTime) :: Double) ++ " s"

  -- HMatrix implementation
  startTimeExpm <- getCurrentTime
  let resultExpm = expm mat
  endTimeExpm <- getCurrentTime
  putStrLn $ "Time for HMatrix expm implementation: " ++ show (realToFrac (diffUTCTime endTimeExpm startTimeExpm) :: Double) ++ " s"

  -- Display first elements
  putStrLn "First element of our matrix:"
  print $ result ! 0 ! 0
  putStrLn "First element of HMatrix matrix:"
  print $ resultExpm ! 0 ! 0
