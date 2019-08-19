# FSMD-MatrixMultiplication VHDL

Finite State Machine with Datapath (FSMD) to calculate matrix multiplication of two 3x3 matrices each with 8-bit numbers. This project also contains an 8-bit multiplier. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

These examples use [ModelSim® and Quartus® Prime from Intel FPGA](http://fpgasoftware.intel.com/?edition=lite), [GIT](https://git-scm.com/download/win), [Visual Studio Code](https://code.visualstudio.com/download), make sure they are installed locally on your computer before proceeding.


### Installing

A step by step series of commands and steps that tell you how to get the project env running


1-Grab a copy of this repository to your computer's local folder (i.e. C:\projects):
```
$ cd projects
$ git clone https://github.com/Ammar-Reda/FSMD-MatrixMultiplication.git
```

2-Use Visual Studio Code (VSC) to edit and view the design files:
```
$ cd FSMD-MatrixMultiplication
$ code .
```

3-From the VSC View menu, choose Terminal, in the VCS Terminal, create a "work" library:
```
$ vlib work
```
4-Compile all the design units:
```
$ vcom *.vhd
```

## Running the tests

6-Open [mat_mul_vectors.vec](https://github.com/Ammar-Reda/FSMD-MatrixMultiplication/blob/master/mat_mul_vectors.vec) (C:\projects\FSMD-MatrixMultiplication\mat_mul_vectors.vec), Enter both matrix A and B values (in binary) in the specified scheme.

5- Design simulation:
```
$ vsim work.mat_mul_tb
```

6-In the ModelSim window, press "run-all" then "stop".

7-Open [mat_mul_results.vec](https://github.com/Ammar-Reda/FSMD-MatrixMultiplication/blob/master/mat_mul_results.vec) (C:\projects\FSMD-MatrixMultiplication\mat_mul_results.vec), To view the result of matrix A, B multiplication (output matrix C).
## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/Ammar-Reda/FSMD-MatrixMultiplication/blob/master/LICENSE) file for details

