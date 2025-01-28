import numpy as np
from scipy.linalg import expm
import time

def norm(matrix):
    return np.sqrt(np.sum(matrix**2))

def scale_matrix(matrix, scaling_factor=0):
    while norm(matrix) > 2:
        matrix = matrix / 2
        scaling_factor += 1
    return matrix, scaling_factor

def scaling_the_matrix(matrix, scaling_factor):
    for _ in range(scaling_factor):
        matrix = matrix @ matrix
    return matrix

def factorial(n):

    result = 1
    for i in range(2, n + 1):
        result *= i
    return result

def lagrange_remainder_exact(matrix, n):
    matrix_norm = norm(matrix)  
    remainder = (np.exp(matrix_norm) / factorial(n + 1)) * (matrix_norm ** (n + 1))
    return remainder

def taylor_series(matrix, eA, last_term, n, epsilon):
   
    next_term = (last_term @ matrix) / n
    new_eA = eA + next_term
    
    
    remainder = lagrange_remainder_exact(matrix, n)
    if remainder < epsilon:
        return new_eA
    return taylor_series(matrix, new_eA, next_term, n + 1, epsilon)

def matrix_exponential(matrix, epsilon):
   
    scaled_matrix, scaling_factor = scale_matrix(matrix)
    identity_matrix = np.eye(matrix.shape[0])
    eA = taylor_series(scaled_matrix, identity_matrix, identity_matrix, 1, epsilon)
    return scaling_the_matrix(eA, scaling_factor)

def read_data(path, delim):
   
    try:
        matrix = []
        with open(path, 'r') as f:
            lines = f.readlines()
        for line_num, line in enumerate(lines):
            try:
                clean_line = line.strip().replace(delim, ' ').split()
                row = [float(num) for num in clean_line]
                matrix.append(row)
            except ValueError:
                print(f"Skipping invalid line {line_num + 1}: {line.strip()}")
        matrix = np.array(matrix)
        if matrix.shape[0] != matrix.shape[1]:
            raise ValueError("Matrix is not square.")
        return matrix
    except FileNotFoundError:
        print(f"File not found: {path}")
        return np.array([])

def main():
    file_path = "C:/software languge/exp_data.txt" 
    delimiter = ',' 
    epsilon = 1e-6

    
    matrix = read_data(file_path, delimiter)

   
    if matrix.size == 0:
        print("Matrix data is invalid or file is missing.")
        return

   
    start_time = time.time()
    result = matrix_exponential(matrix, epsilon)
    end_time = time.time()
    print(f"Time for our implementation: {end_time - start_time:.6f} s")

   
    start_time_expm = time.time()
    scipy_result = expm(matrix)
    end_time_expm = time.time()
    print(f"Time for SciPy implementation: {end_time_expm - start_time_expm:.6f} s")

   
    print("First element of our computed matrix:")
    print(result[0, 0])
    print("First element of SciPy matrix:")
    print(scipy_result[0, 0])

if __name__ == "__main__":
    main()
