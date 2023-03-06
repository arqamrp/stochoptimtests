## Project info

Project title: StochOptim: 

Project short title (30 characters): 

URL of project idea page: [https://github.com/rstats-gsoc/gsoc2023/wiki/StochOptim-stochastic-optimization-in-R](https://github.com/rstats-gsoc/gsoc2023/wiki/StochOptim-stochastic-optimization-in-R)

## Bio of Contributor 

I am a sophomore undergraduate in Statistics and Data Science at the Indian Institute of Technology, Kanpur. I enjoy
My introduction to R took place through the course, Data Science Lab I, taught by Dr Dootika Vats, an ex R project GSOC alumna (2015) herself. In the course, I learned the fundamentals of R, including things like benchmarking, Rshiny, Rmarkdown and Rcpp. 
I am also currently doing a course, Statistical Computing, which includes optimisation methods and am also somewhat familiar with the theoretical content of the project.


## Contact Information 

Contributor name: Arqam Patel

Contributor postal address: Hall 5, IIT Kanpur, Kanpur, Uttar Pradesh, india, 208016

Telephone(s): +91 7715863670 

Email(s): 
arqamrp@gmail.com
arqamrp21@iitk.ac.in

Other communications channels: Skype/Google+, etc. : 


## Contributor affiliation

Institution: Indian Institute of Technology, Kanpur

Program: BS, Statistics and Data Science

Stage of completion: 2nd year out of 4

Contact to verify: Dr Dootika Vats, dootika@iitk.ac.in


## Schedule Conflicts:

Classes at my college will resume classes from July 31.

## Mentors

Evaluating mentor name and email: John C Nash, 

Co-mentor name(s) and email(s): (at least one co-mentor required, who has to be from a different physical institution from the evaluating mentor)

Have you been in touch with the mentors? When and how? 

## Coding Plan and Methods

The package aims to provide two main sorts of functionality:
- a way to call multiple optimisers using a single interface
- a way to compare these optimisers in the given use-case

To start, we would need a comprehensive list of the optimisers, their various arguments that can be tweaked, and the default configurations.





Describe in detail your plan for completing the work.  What functions will be written, how and when will you do design, how will you verify the results of your coding?  The sub-section headings below are examples only.  Each project is different, please make your application appropriate to the work you propose.  

Describe perceived obstacles and challenges, and how you plan to overcome them.

The best R GSoC applications tend to be 10+ pages printed.  Planning is a key part of a successful project, and demonstrates to the mentors that you are qualified and engaged.


## Timeline

(consult GSOC schedule)

Provide a detailed timeline of how you plan to spend your summer.  Don't leave testing and documentation for last, as that's almost a guarantee of a failed project. 

Make sure to identify what you plan to accomplish in each month of the project.  Google has asked organizations to be more directive about milestones. Also be sure to identify what you will accomplish between acceptance and the official start of coding. (Hint: establishing your build environment and researching existing work shouldn't wait till project start)

What is your contingency plan for things not going to schedule? We understand things change, but how are you planning to address changes and setbacks?

If you have other time commitments that will interfere with GSoC, we highly recommend explaining how you will front-load the work before coding start or work extra early on to build a cushion!

## Management of Coding Project

How do you propose to ensure code is submitted / tested?

How often do you plan to commit?  What changes in commit behavior would indicate a problem?

I plan to push commits every two days.

## Test

For the qualification test, I solved five tasks:
### [Rastrigin function](https://github.com/arqamrp/stochoptimtests/blob/main/tests/rastrigin.R):
I implemented the Rastrigin function, a common test function for optimisation, for n-dimensional vectors, using the definition on its Wikipedia page. I then plotted it in three dimensions (for 2D vectors, with the z axis representing fuunction value). I also guessed its global minimum and provided the rationale behind my guess.

![Rastrigin plot](https://github.com/arqamrp/stochoptimtests/blob/main/tests/rastrigin.png)

### [optim()](https://github.com/arqamrp/stochoptimtests/blob/main/tests/optim.R): 

I used the default Nelder-Mead local optimiser on five randomly initialised starting points (setting a seed for reproducibility). Then, fixing the starting point, I used the five different algorithm options within optim() (using separate calls for each method) to compare them on the basis of the minima found and time taken (measured using rbenchmark). 
After this, I used the ucminf function to implement another local optimiser (not available in optim) on those five points, and then the optimx function to run and compare multiple methods with the same initial point using one function call.



### [Stochastic optimisation](https://github.com/arqamrp/stochoptimtests/blob/main/tests/stochastic_optimisation.R) 

I used three different global optimisers: DEoptim, GenSA and psoptim, which are listed under different classes of methods in [^2]. The three are based on different algorithms: Differential Evolutionary optimisation, Generalized Simulated Annealing, and Particle Swarm Optimisation. 
We compare them in terms of precision achieved and time taken for 10 replications (using default function arguments).

### [Other test functions]()



















