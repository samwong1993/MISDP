1. CVX with mosek is required and do not use Gurobi.
Follow the guidance of: https://blog.csdn.net/u012705410/article/details/78196927
2. We provide two demo data settings demo_2D.mat/demo_3D.mat. 
3. generator.m: Generate synthetic data.
4. OA_master.m/NLP_P.m/NLP_D.m: Solving the corresponding subproblem in our paper.
5. range: Calculate the range of the integer variables.
6. solve_x: Recover x when n_i is fixed by solving the original problem.
7. main.m: Demo of our proposed OA.
