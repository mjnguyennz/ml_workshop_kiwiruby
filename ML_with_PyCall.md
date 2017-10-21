# Machine Learning in Ruby using PyCall

## Introduction

In this exercise, we will explore the machine learning tools available in Python while still writing Ruby.
This is thanks to a fantastic ruby gem called [`pycall`](https://github.com/mrkn/pycall.rb). By using this gem, we can leverage the many Python libraries for data science and data visualisation.

## Setup for using PyCall in this workshop

1.
Install Python 3.5.3 or higher. These installations will come with package management tool `pip3`, so you will not have to install it separately.
- If you have Windows or Linux, instructions on installing Python can be found at: http://docs.python-guide.org/en/latest/starting/installation/

- Use Homebrew for Mac installation:
```
$ brew update
$ brew install python3
```
- Confirm that your version of python is greater than 3.5.3
```
$ python3 --version
```
- Confirm that pip is also installed
```
$ pip3 --version
```

2.
Install Python libraries
```
$ pip3 install numpy
$ pip3 install pandas
$ pip3 install scipy
$ pip3 install scikit-learn
```

3.
Install the necessary Ruby gems:
```
$ cd pycall_examples
$ bundle install
```

4.
Create a `.env` file with the `PYTHON` environment variable to tell PyCall the location of your python install. Setting this environment variable is how you can adjust the version of Python invoked from PyCall.
```
PYTHON=path_to_your_python_install
```

# Time to have some fun with PyCall!

Read through and run the example scripts in the pycall_examples folder. Take some time to experiment!

1. `ruby pycall_predict.rb iris_predict.csv` - Trains a classifier model to predict iris data passed from csv file argument. This script demonstrates how to use sklearn datasets, as well as a dataset from csv for training.
  - Experiment #1: Modify the script to use a different classifier.
  - Experiment #2: Modify the script to use a different data set, your own data or from elsewhere.
  - Experiment #3: Modify the script to solve a non-classification problem.

2. `ruby pycall_evaluate.rb` - Evaluates a series of classifier models configured with different tuning parameters.
  - Experiment #1: Modify the script to use a different classifier and/or different tuning parameters.
  - Experiment #2: Modify the script to evaluate a series of models trained with different amounts of training data by changing the amount of examples in your dataset to have 50, 100 and 150 examples. (Hint: Pass a parameter into the `make_classification` method)
  - Experiment #3: Modify the script to use a different data set, your own data or from elsewhere.
  - Experiment #4: Modify the script to evaluate for regression models instead.

3. `ruby pycall_classification_example.rb` - Shows how different classifier algorithms handle different types of data, and plots the results.
  - Experiment #1: Add/swap out some more algorithms and datasets.
  - Experiment #2: Experiment with the plotting and customise the information displayed, etc.
