# Pontryagin's Minumum Principle


```{admonition} TODO
:class: toggle
* Make this more clear and relevant to the flow.*
```

Equivalently, "Pontryagin's Maximum Pricincple"

## Motivation

For a optimal control problem, how do we know if the solution is optimal? 

This principle provides a set of first order necessary conditions for deterministic optimal control problems. In discrete-time, this is a special case of the KKT conditions.

## Theory

Given our objective

$$
\begin{aligned}
&\min _{\substack{x_{1 : N} \\ u_{1 : N-1}}} \sum_{k=1}^{N-1} \left[ \mathcal{L}\left(x_k, u_k\right)\right] +\mathcal{L}_F\left(x_N\right) \\
& \quad \text{s.t.} \\
& \qquad f\left(x_k, u_k\right) - x_{k+1} = 0 \qquad \text{(dynamics constraints)}\\
\end{aligned}
$$

We can form the lagrangian 

$$
L=\sum_{k=1}^{N-1}\left[\mathcal{L}\left(x_k, u_k\right)+\lambda_{k+1}^T\left(f\left(x_k, u_k\right)-x_{k+1}\right)\right]+\mathcal{L}_F\left(x_N\right)
$$

Introducing the "Hamiltonian" ($H$) we have

$$
\begin{aligned}
& H(x, u, \lambda)=L(x, u)+\lambda^{\top} f(x, u) \\
& \Rightarrow L=H\left(x, u, \lambda_2\right)+\left[\sum_{k=2}^{N-1} H\left(x_k, u_k \lambda_{k+1}\right)-\lambda_k^{\top} x_k\right]+L_f\left(x_N\right)-\lambda_N^{\top}\left(x_N\right)
\end{aligned}
$$

Taking the derivatives with respect to $x$ and $\lambda$; and an explicit minimisation for $u$

$$
\begin{aligned}
& \frac{\partial L}{\partial \lambda_k}=f\left(x_k, u_k\right)-x_{k+1}=\frac{\partial H}{\partial \lambda_k}-x_{k+1}=0 \\
& \frac{\partial L}{\partial x_k}=\frac{\partial \mathcal{L}}{\partial x_k}+\lambda_{k+1}^T \frac{\partial f}{\partial x_k}-\lambda_k^T=0 \\
& \frac{\partial L}{\partial x_N}=\frac{\partial \mathcal{L}_F}{\partial x_N}-\lambda_N^T \\
& u_k=\underset{\widetilde{u}}{\operatorname{argmin}} H\left(x_k, \tilde{u}, \lambda_{k+1}\right) \text { s.t. } \underbrace{u \in \mathcal{U}}_{\text {u is feasible }}
\end{aligned}
$$

In concise notation

$$
\begin{aligned}
 x_{k+1}&=\nabla_\lambda H\left(x_k, u_k, \lambda_{k+1}\right) \\
 \lambda_k&=\nabla_x H\left(x_k, u_k, \lambda_{k+1}\right) \\
 u_k&=\underset{a}{\operatorname{argmin}} H\left(x_k, \tilde{u}, \lambda_{k+1}\right) \text { s.t. } u \in \mathcal{U} \\
 \lambda_N&=\frac{\partial L_F}{\partial x_N}
\end{aligned}
$$

```{admonition}  They are almost identical in continuous time
:class: toggle
$$
\begin{aligned}
 \dot{x}&=\nabla_\lambda H(x, u, \lambda) \\
-\dot{\lambda} &=\nabla_x H(x, u, \lambda) \\
 u&=\underset{\widetilde{u}}{\operatorname{argmin}} H(x, \tilde{u}, \lambda) \text { s.t. } u t u \\
 \lambda\left(t_t\right)&=\frac{d L_F}{\partial x}
\end{aligned}
$$
```
## Practical

* Historically many algorithms were base on integrating th continuous ODEs foreward/backward to do gradient descent on $u(t)$.
* These are called "indirect" or "shooting" methods.
* In continuous time $\lambda(t)$ is called the costate trajectory.
* These methods have largely fallen out of favour as computers have gotten faster.

