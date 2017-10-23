# Machine Learning in Ruby using PyCall

## Introduction

In this exercise, we will explore the machine learning tools available in Python while still writing Ruby.
This is thanks to a fantastic ruby gem called [`pycall`](https://github.com/mrkn/pycall.rb). By using this gem, we can leverage the many Python libraries for data science and data visualisation.

## Setup for using PyCall in this workshop

1. Install [Docker](https://www.docker.com/community-edition#/download). To keep installation of all the various libraries and language dependencies consistent across everyone's various operating systems, we will be use Docker to run our Ruby + Python environment. For Windows users, Docker Community Edition may not be available for your version of Windows, but you can look into the [Docker Toolbox](https://www.docker.com/products/docker-toolbox). Failing that, you can always install a Linux VM and install Docker onto that.

2. Clone this repo so you have access to the code examples locally.

3. Download the docker image. The image includes Ruby, Python, and all the necessary libraries.
The code in `pycall_examples` can be found in the /usr/app working directory.
```
docker pull mjnguyennz/ml_pycall
```

3. Run the docker image and connect to it with bash terminal.
```
  docker run -t -i mjnguyennz/ml_pycall /bin/bash
```

4. The Docker image should have already created a `.env` file with the `PYTHON` environment variable to tell PyCall the location of your python install. Confirm that `cat .env` outputs PYTHON environment variable matching the output of `which python3`

# Time to have some fun with PyCall!

Read through and run the example scripts in the `pycall_examples` folder. Sing out if you have questions, and take some time to experiment!
If you choose to make your code changes in your local copy of `/pycall_examples` rather than in the container, you can copy them to your docker container by opening a new terminal window and issuing the following:
```
cd pycall_examples
docker cp pycall_predict.rb <container_id>:/usr/app/pycall_predict.rb`
```
You will now see that in your original docker bash terminal, the file will have updated and ready to run.

1. `ruby pycall_predict.rb iris_predict.csv` - Trains a classifier model to predict iris data passed from csv file argument. This script demonstrates how to use sklearn datasets, as well as a dataset from csv for training.
  - Experiment #1: Modify the script to use a different classifier.
  - Experiment #2: Modify the script to use a different data set, your own data or from elsewhere.
  - Experiment #3: Modify the script to solve a non-classification problem.

2. `ruby pycall_evaluate.rb` - Evaluates a series of classifier models configured with different tuning parameters.
  - Experiment #1: Modify the script to use a different classifier and/or different tuning parameters.
  - Experiment #2: Modify the script to evaluate a series of models trained with different amounts of training data by changing the amount of examples in your dataset to have 50, 100 and 150 examples. (Hint: Pass a parameter into the `make_classification` method)
  - Experiment #3: Modify the script to use a different data set, your own data or from elsewhere.
  - Experiment #4: Modify the script to evaluate for regression models instead.

3. `ruby pycall_classification_example.rb` - Shows how different classifier algorithms handle different types of data, and plots the results. The plot is saved into a file called `comparison.png`. You can retrieve the image to view locally with `docker cp <container_id>:/usr/app/comparison.png <where you want to put the file>`
  - Experiment #1: Add/swap out some more algorithms and datasets.
  - Experiment #2: Experiment with the plotting and customise the information displayed, etc.
