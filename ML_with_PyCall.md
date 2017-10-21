# Machine Learning in Ruby using PyCall

# Introduction

In this exercise, we will explore the machine learning tools available in Python while still writing Ruby.
This is thanks to a fantastic ruby gem called `pycall`. By using this gem, we can leverage the many Python libraries for data science and data visualisation.

# Setup for PyCall

1. Install Python 3.5 or higher
If you have Windows or Linux, instructions on installing Python can be found at: http://docs.python-guide.org/en/latest/starting/installation/
Be sure to install Python version 3.5 or higher. These installations will come with package management tool `pip`, so you will not have to install it separately.

Use Homebrew for Mac installation
```
$ brew update
$ brew install python3
```
Confirm that your version of python is greater than 3.5
`$ python3 --version`
Confirm that pip is also installed
`$ pip3 --version`
To make things easier you can optionally create aliases:
Add to your source ~/.bash_profile
```
alias python='python3'
alias pip='pip3'
```
Run your .bashprofile to pick up your changes:
`$ source ~/.bash_profile`

2. Install python libraries using `pip` (use pip3 if you opted not to create aliases)
```
$ pip install numpy
$ pip install pandas
$ pip install scipy
$ pip install scikit-learn
```

3. Install the necessary Ruby gems:
```
$ gem install pycall
$ gem install numpy
$ gem install matplotlib
$ gem install pandas
```

4. Set an environment variable to tell PyCall the location of your python install. Setting this environment variable is how you can adjust the version of Python invoked from PyCall.
```
$ PYTHON=/usr/local/bin/python3
$ export PYTHON
```

# Time to have some fun with PyCall!

Read through and run the example scripts in the pycall_examples folder. Take some time to experiment!

1. `ruby pycall_predict.rb iris_predict.csv` - Trains a classifier model to predict iris data passed from csv file argument.
  Experiment #1: Modify the script to use a different classifier.
  Experiment #2: Modify the script to use a different data set, your own data or from elsewhere.
  Experiment #3: Modify the script to solve a non-classification problem.

2. `ruby pycall_evaluate.rb` - Evaluates a series of classifier models configured with different tuning parameters.
  Experiment #1: Modify the script to use a different classifier and/or different tuning parameters.
  Experiment #2: Modify the script to evaluate a series of models trained with different amounts of training data. (Pass a parameter into the `make_classification` method)
  Experiment #3: Modify the script to use a different data set, your own data or from elsewhere.
  Experiment #4: Modify the script to evaluate for regression models instead.

3. `ruby pycall_classification_example.rb` - Shows how different classifier algorithms handle different types of data, and plots the results.
  Experiment #1: Add/swap out some more algorithms and datasets.
  Experiment #2: Experiment with the plotting and customise the information displayed, etc.
