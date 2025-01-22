# Matrix Exponential Solver

This project provides **Python** and **Haskell** implementations of the **matrix exponential**, a mathematical operation widely used in scientific computations, control theory, and quantum mechanics. 
Both implementations deliver accurate and efficient results, with rigorous convergence checking using **Lagrange's remainder** for the power series computation.

---

## **Features**

- Computes the **matrix exponential** \( e^M \) for any square matrix \( M \).
- Available in **Python** and **Haskell**.
- Adjustable precision with the `epsilon` parameter.
- Incorporates **Lagrange's remainder** to ensure accurate convergence during power series computations.
- Python implementation leverages `numpy` and `scipy` for efficient matrix operations.
- Haskell implementation uses the **HMatrix** library for efficient and precise matrix computations.
- Modular and easy-to-extend codebases.

---

## **Installation**

### Python

To run the Python implementation, ensure you have Python 3.7 or later installed. Then, install the required dependencies:

```bash
pip install numpy scipy
```

### Haskell

To run the Haskell implementation, install the **HMatrix** library. If you're using `stack`:

```bash
stack install hmatrix
```

Or, for `cabal`:

```bash
cabal install hmatrix
```

---

## **Usage**

### Python

1. Clone this repository:
   ```bash
   git clone https://github.com/GadAzriel/Scientific-Programming.git
   cd Scientific-Programming
   ```

2. Import the `matrix_exponential` function into your Python script:
   ```python
   from main import matrix_exponential
   ```

3. Example usage:
   ```python
   import numpy as np
   from main import matrix_exponential

   # Define a square matrix
   M = np.array([[0, 1], [-1, 0]])

   # Compute the matrix exponential
   result = matrix_exponential(M)
   print("Matrix Exponential:\n", result)
   ```

### Haskell

1. Clone the repository and navigate to the Haskell implementation:
   ```bash
   git clone https://github.com/GadAzriel/Scientific-Programming.git
   cd Scientific-Programming/haskell
   ```

2. Run the program using `stack` or `ghci`:
   ```bash
   stack run
   ```

3. Example usage:
   Define a matrix in a file (e.g., `matrix.txt`) with space-separated rows:
   ```
   0 1
   -1 0
   ```

   Run the program:
   ```bash
   ./MatrixExponential matrix.txt
   ```

---

## **Examples**

### Example 1: Identity Matrix (Python and Haskell)

**Input (Python):**
```python
M = np.eye(3)
result = matrix_exponential(M)
```

**Output:**
```text
Matrix Exponential:
[[2.71828183 0.         0.        ]
 [0.         2.71828183 0.        ]
 [0.         0.         2.71828183]]
```

**Input (Haskell):**
Content of `matrix.txt`:
```
1 0 0
0 1 0
0 0 1
```

Run the program:
```bash
./MatrixExponential matrix.txt
```

**Output:**
```text
Matrix Exponential:
(2.718281828459045 0.0 0.0)
(0.0 2.718281828459045 0.0)
(0.0 0.0 2.718281828459045)
```

### Example 2: Rotation Matrix

**Input (Python):**
```python
M = np.array([[0, -1], [1, 0]])
result = matrix_exponential(M)
```

**Output:**
```text
Matrix Exponential:
[[0.54030231 -0.84147098]
 [0.84147098  0.54030231]]
```

**Input (Haskell):**
Content of `matrix.txt`:
```
0 -1
1 0
```

Run the program:
```bash
./MatrixExponential matrix.txt
```

**Output:**
```text
Matrix Exponential:
(0.5403023058681398 -0.8414709848078965)
(0.8414709848078965 0.5403023058681398)
```

---

## **Contributing**

Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Description of changes"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

## **Contact**

For questions or suggestions, feel free to reach out:
- **Email**: gadazriel7@gmail.com
- **GitHub**: [GadAzriel](https://github.com/GadAzriel)
- **Email**: adar688@gmail.com
- **GitHub**: [AdarBudomski](https://github.com/adar688)

Happy coding! 🚀
