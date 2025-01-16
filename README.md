# Scientific Programming: Matrix Exponential Solver

This project provides a Python implementation of the **matrix exponential**, a mathematical operation widely used in scientific computations, control theory, and quantum mechanics. 
The script leverages popular Python libraries such as numpy and scipy to deliver accurate and efficient results.

---

## **Features**

- Computes the **matrix exponential** \( e^M \) for any square matrix \( M \).
- Adjustable precision with the `epsilon` parameter.
- Uses efficient matrix operations for performance.
- Modular and easy-to-extend codebase.
- Computes the matrix exponential using the Power Series and Norm algorithm.

---

## **Installation**

To run this project, ensure you have Python 3.7 or later installed. Then, install the required dependencies:

```bash
pip install numpy scipy
```

---

## **Usage**

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

---

## **Examples**

### Example 1: Identity Matrix

Input:
```python
M = np.eye(3)
result = matrix_exponential(M)
```
Output:
```text
Matrix Exponential:
[[2.71828183 0.         0.        ]
 [0.         2.71828183 0.        ]
 [0.         0.         2.71828183]]
```

### Example 2: Rotation Matrix

Input:
```python
M = np.array([[0, -1], [1, 0]])
result = matrix_exponential(M)
```
Output:
```text
Matrix Exponential:
[[0.54030231 -0.84147098]
 [0.84147098  0.54030231]]
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

## **License**

This project is licensed under the MIT License. See the LICENSE file for details.

---

## **Contact**

For questions or suggestions, feel free to reach out:
- **Email**: gadazriel7@gmail.com
- **GitHub**: [GadAzriel](https://github.com/GadAzriel)
- **Email**: adar688@gmail.com
- **GitHub**: [AdarBudomski](https://github.com/adar688)

Happy coding! 🚀

