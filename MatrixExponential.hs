module MatrixExponential where

import Data.List (transpose)
import System.IO
import Text.Read (readMaybe)

type Matrix = [[Double]]
type Vector = [Double]

-- Get first element of matrix
getFirstElement :: Matrix -> Double
getFirstElement m = (head . head) m

-- Basic matrix operations
multiplyMatrices :: Matrix -> Matrix -> Matrix
multiplyMatrices a b = 
    [[sum $ zipWith (*) row col | col <- transpose b] | row <- a]

addMatrices :: Matrix -> Matrix -> Matrix
addMatrices = zipWith (zipWith (+))

divideMatrixByScalar :: Matrix -> Double -> Matrix
divideMatrixByScalar matrix scalar = 
    map (map (/ scalar)) matrix

identityMatrix :: Int -> Matrix
identityMatrix n = 
    [[if i == j then 1 else 0 | j <- [0..n-1]] | i <- [0..n-1]]

maxNorm :: Matrix -> Double
maxNorm matrix = maximum $ map (sum . map abs) matrix

matrixExponential :: Matrix -> Double -> Matrix
matrixExponential m epsilon = go identityM identityM 1
  where
    n = length m
    identityM = identityMatrix n
    go result term k
      | nextTermNorm < epsilon = result
      | otherwise = go newResult newTerm (k + 1)
      where
        newTerm = divideMatrixByScalar (multiplyMatrices term m) k
        newResult = addMatrices result newTerm
        nextTermNorm = maxNorm (multiplyMatrices newTerm m) / (k + 1)

scaleAndSquareExponential :: Matrix -> Double -> Matrix
scaleAndSquareExponential m epsilon = 
    let maxNormValue = maxNorm m
        s = max 0 (floor (logBase 2 maxNormValue) + 1)
        scaledM = divideMatrixByScalar m (2 ^ s)
        eMScaled = matrixExponential scaledM epsilon
        finalResult = iterate (multiplyMatrices eMScaled) eMScaled !! (s - 1)
    in if s == 0 then eMScaled else finalResult

readMatrix :: FilePath -> IO Matrix
readMatrix path = do
    content <- readFile path
    let rows = lines content
        matrix = mapM (mapM readDouble . words) rows
    case matrix of
        Just m | isSquareMatrix m -> return m
        _ -> error "Invalid matrix format or non-square matrix"
  where
    readDouble :: String -> Maybe Double
    readDouble = readMaybe
    isSquareMatrix :: Matrix -> Bool
    isSquareMatrix m = 
        let rows = length m
        in all ((== rows) . length) m

main :: IO ()
main = do
    putStrLn "Reading matrix from exp_data.txt..."
    matrix <- readMatrix "exp_data.txt"
    let epsilon = 1e-6
        firstVal = getFirstElement matrix
    
    putStrLn $ "First value of input matrix: " ++ show firstVal
    
    putStrLn "\nCalculating using power series method..."
    let result1 = matrixExponential matrix epsilon
    putStrLn $ "First value of result (power series): " ++ show (getFirstElement result1)
    
    putStrLn "\nCalculating using scale and square method..."
    let result2 = scaleAndSquareExponential matrix epsilon
    putStrLn $ "First value of result (scale and square): " ++ show (getFirstElement result2)