# Machine Learning in Ruby - BigML Quickstart

- [Introduction](#introduction)
- [Using the Dashboard UI](#using-the-dashboard-ui)
  - [Upload your ML Ready Data](#upload-your-ml-ready-data)
  - [Create a dataset](#create-a-dataset)
  - [Visualising your dataset](#visualising-your-dataset)
  - [Split the dataset into training, test/cross-validation datasets](#split-the-dataset-into-training-testcross-validation-datasets)
- [Working with regression (predicting numerical or categorical values)](#working-with-regression-predicting-numerical-or-categorical-values)
  - [Create a regression model from your dataset](#create-a-regression-model-from-your-dataset)
  - [Visualising your regression model](#visualising-your-regression-model)
  - [View the Model Summary Report](#view-the-model-summary-report)
- [Working with logistical regression (predicting categorical values)](#working-with-logistical-regression-predicting-categorical-values)
  - [Create a logistical regression model from your dataset](#create-a-logistical-regression-model-from-your-dataset)
  - [Visualising your logistic regression model](#visualising-your-logistic-regression-model)
  - [Evaluating your model for predictive performance](#evaluating-your-model-for-predictive-performance)
  - [Tune and optimise your model for better performance](#tune-and-optimise-your-model-for-better-performance)
  - [Running predictions from your model](#running-predictions-from-your-model)
  - [Switching between Dev and Prod modes](#switching-between-dev-and-prod-modes)
- [Using BigML Machine Learning with Ruby](#using-bigml-machine-learning-with-ruby)
  - [Extract your models to perform local predictions in Ruby (only available for regression models)](#extract-your-models-to-perform-local-predictions-in-ruby-only-available-for-regression-models)
  - [Using big_ml gem](#using-big_ml-gem)


# Introduction
We will be exploring Machine Learning with two tools. The first is a Machine Learning cloud service called BigML. Register for a free account at [BigML.com.au](https://www.bigml.com.au)

BigML can handle *some* of your data processing for you automatically, such as expanding categories into booleans, and expanding date-time fields into multiple fields. Normalisation of numerical data is not necessary, and redundant fields do not affect BigML models negatively. Incomplete data can also be filtered out, as well as very basic imputation and feature engineering can be performed in the Dataset stage, but this guide will not touch upon that. This guide attempts to give a basic overview to reinforce the Machine Learning workflow. Feel free to explore the BigML documentation further on their website on your own.

In this guide, we will be focusing on supervised regression and logistic regression problems, as they are the most commonly used types of Machine Learning used. Regression models can be used to predict numerical values as well as categorical fields. In BigML, logistical regression models can only predict categorical fields.

# Using the Dashboard UI

## Upload your ML Ready Data
1. Go to "Sources" screen.
2. Click on 📄+ icon towards the upper right. Alternatively, you can drag and drop your file onto the page.
3. Upload your file data.
4. Click on your new Source to view it. Note that BigML transposes rows and columns for display. Source view only allows a preview of the first 25 instances in your data.
5. Use this preview to double check that BigML has properly parsed your data correctly.
6. If there is an issue, click on "Configure source" (cylinder with gears icon to the right of your Source's name), and adjust the settings appropriately for your file.

## Create a dataset
1. Click on your "Source" that you want to create the dataset from.
2. Click on the "bar graph with gears" button towards the upper right (to the right of your Source's name).
3. Give your dataset a name and make sure to use 100% of the source data.
4. Select a subset of fields if you wish, deselect the fields you don't want to include by mousing over the field row and unticking the checkbox that appears to the right of the field name.
5. Click "Create Dataset" button. This will take you to a view of your dataset.
6. BigML assumes the last field is your "objective field", i.e., the field you wish to predict. To change your "objective field, mouse over the name of the field you'd like to be your target, and click on the pencil icon that appears. Click on the "crosshairs" icon to make this field your "objective field".

## Visualising your dataset
1. You will see histograms for each field to the right.
2. Mouseover the histograms and see counts of values. Numeric data will have a σ button appear. Mousing over this button will give basic statistics about the values for that field in your dataset.
3. You can also see dynamic scatterplots of your data by clicking the button directly above the field name column. Change the X and Y columns to further explore your data. If your dataset has more than 500 instances, a sample of 500 instances from your dataset will be used in the dynamic scatterplot.
4. Exit the scatterplot by clicking on the Dashboard link.

## Split the dataset into training, test/cross-validation datasets
BigML splits a dataset into two. To make our three datasets (training, test and cross-validation), we will have to split the dataset into two, and then one of the smaller datasets once again.
1. Click on "Datasets" menu item.
2. Click on your Dataset.
3. Mouseover the Gears icon (to the right of the dataset name) and click on "Training and Test Set Split"
4. Adjust the ratio to 60% and 40%.
5. Name the datasets "Training" and the 40% one as "Test and Cross-Validation."
6. Click on "Create Training | Test"
7. Repeat steps 1-6 to split the "Test and Cross-Validation" dataset, but using 50-50% split and appropriate names.

# Working with regression (predicting numerical or categorical values)
## Create a regression model from your dataset
1. Click on the training dataset on which you want to train a model.
2. Mouseover the gears icon to the right of your dataset's name. Click on "Configure Model"
3. You can edit the objective field (if you haven't done so already), as well as choose a pruning strategy. Pruning is a way to reduce overfitting of the data.
  * Smart Pruning (the default): considers pruning the nodes with less than 1% of the instances.
  * Statistical Pruning: considers every node for pruning.
  * No Statistical Pruning: deactivates pruning altogether.
4. You can do more advanced configuration under "Advanced configuration" - this is out of scope for this guide, see the BigML documentation for more details. Some of these configuration setting here can be used to tune your models.
5. Create your model by clicking the "Create Model" button. Your newly created regression models can always be found under the menu "Supervised" -> "Models"

## Visualising your regression model
1. Upon creating your model, you are taken to a view of your model showing the decision tree depiction of the model generated. This is the Tree view.
  * Each node represents an input field.
  * Mouseover nodes to see the histogram and best split on that value, and the "prediction path" to get to that node, and the number of instances from the dataset following that path, as well as confidence (for classification) or expected error.
  * Click on a node to "zoom in" on the subtree under that node. Click on the root node to zoom back out.
  * Filters are available at the top to filter only certain output values, etc.
  * You can also create a dataset from any node of your model (out of scope for this guide)
2. Another way to visualise your model is to click on the "Sunburst" button (looks like a weird bulls eye) to the left side name. The sunburst is a way to visualise your model as if you were looking top-down onto your model's decision tree.
  * Arc length indicates the percentage of the dataset in that path.
  * Change colours according to field, prediction value or confidence/expected error.
  * Click on a 'ring' to zoom into that level of the tree. Click on the centre to move one level up at the time until you get back to the top.
3. Lastly, you can view your model in a PDP (Partial Dependence Plot). This shows a graphical representation of how two input fields affect the objective field, if all other inputs are held constant.

## View the Model Summary Report
1. Click on the (clipboard with down arrow) to the right of your model's name.
2. The Field importance tab shows the importance of different fields relative to each other.
3. The Summary tab shows the distribution of the data, etc.

# Working with logistical regression (predicting categorical values)
## Create a logistical regression model from your dataset
1. Click on the training dataset on which you want to train a model.
2. Mouseover the gears icon to the right of your dataset's name. Click on "Configure Logistic Regression"
3. You can edit the objective field (if you haven't done so already).
4. You can also choose a Default Numeric Value, which is the value to use for any missing numeric values in the dataset, or choose to exclude any data with missing values by clicking on the "N/A" button. (Missing data is included by default)
5. You can set the Eps (stopping criteria for producing the model). Higher values make the model to be faster built but they may result in a worse predictive performance.
6. You can also decide whether to include stats, which are not included by default, because they increase the time considerably to build the model. Exploring these stats are outside the scope of this guide.
7.  You can do more advanced configuration under "Advanced configuration" - this is out of scope for this guide, see the BigML documentation for more details. Many of these configuration settings here can be adjusted to tune your models.
8. Create your model by clicking the "Create logistic regression" button. Your newly created logistic regression models can always be found under the menu "Supervised" -> "Logistic Regressions"

## Visualising your logistic regression model
1. Upon creating your model, you are taken to a chart view of your model where you can see the impact of the selected input fields on the objective classes predictions given the other inputs remaining constant.
  * In one dimensional view, you may only adjust the X-axis input field, and Y is the probability of each category class.
  * In two dimensional view, you can adjust the X-axis and Y-axis input fields, and the darkness of the colour indicates the probability.
  * Mousing over areas of the chart will dynamically update the stats along the right side.
  * You can adjust any of the other input fields not represented in the chart, which will hold constant for your view of the chart

## Evaluating your model for predictive performance
1. Click on Supervised -> Evaluations
2. Mouseover the cloud with lightning icon, and click "Evaluate a model" or "Evaluate a logistic regression" depending on which you are interested in.
3. Select the model you want to evaluate, and the test set you want to use. The advanced configurations are out of scope for this guide.
4. Click "Evaluate". This will create an Evaluation, which you can refer back to at any time.
5. If your objective field was a classification category, you will be shown a "Confusion Matrix" along with many graph options which are out of scope for this guide.
  * In the confusion matrix, mousing over the table's top and side headers will colour-code the various cells with colours corresponding to correct predictions of "True Positives" and "True Negatives" and incorrect predictions of "False Positives" and "False Negatives"
  * The accuracy of your model is represented by a percentage
    (true negatives + true positives)/(total instances)
  * The precision of your model is represented by a percentage
    (true positives)/(true positives + false positives)
  * The performance is better be measured by the F-measure (aka F-score) than accuracy because this measurement takes into account both false negatives and false negatives.
6. If your objective field was a numerical value, you will be show some statistical measurements used to measure the performance. Explanations of all these measurements are out of scope for this guide, but here are some rules of thumb:
  * Mean Squared Error: squared mean of the model prediction errors for each instance. The lower the better.
  * Mean Absolute Error: mean of the model prediction errors for each instance. The lower the better.
  * R-squared values: The closer the R-squared is to 1, the better the model fits the data.

## Tune and optimise your model for better performance
1. If the evaluation of the dataset did not show the performance you were hoping for, you should try to adjust a few things to see if your model can be improved.
  * Create new models with different training data.
    * remove irrelevant fields from your dataset
    * adding more relevant fields from your dataset
    * increase the quantity of instances in your dataset
  * Create new models with different configurations, such as modifying the pruning strategy, node threshold, missing data strategy, weights on different data inputs, regularization, etc.
  * Try using ensembles (out of scope for this guide)
2. Change some of the following and recreate your model:
3. Evaluate your tuned model with your test dataset as per above.
4. Repeat as necessary.

## Running predictions from your model
1. Click on the model on which you want to create a prediction. (Models are listed under "Supervised" -> "Models" for regression models, or "Supervised" -> "Logistic Regressions" for logistic regression models)
2. Mouseover the "cloud with lightning" icon to the right of your model's name. Click on "Predict".
3. Fill in the form with the appropriate data.
4. The predicted output from your values should appear at the top of the screen, along with the confidence/expected error. For logistic regression predictions, the probabilities for each category will appear as well.
5. Optionally, you can save this prediction by clicking "Save", for future reference. All of your saved regression and logistic regression predictions can be found under "Predictions" -> "Classification & Regression"

## Switching between Dev and Prod modes
You BigML dashboard comes with a Dev mode sandbox, as well as a Production area. To switch between the two, simply click the PROD DEV switch towards the upper right. Sources can be moved from Dev to
Prod and vice versa, but other resources like Datasets, Models, and Predictions cannot be moved between the Dev sandbox and Prod area, like Predictions.

# Using BigML Machine Learning with Ruby
There are two ways to incorporate BigML's Machine Learning into your Ruby codebase.
If you aren't using "online learning" (learning in real time, retraining your models as predictions are  validated), you can download your regression models in Ruby and do all your predictions offline, natively in Ruby.
If you plan to do online learning, then you can use BigML's public REST API. There is a simple ruby client that wraps their APIs called `big_ml`. The [BigML API documentation](https://bigml.com.au/api/) is quite thorough

## Extract your models to perform local predictions in Ruby (only available for regression models)
1. Click on the model you would like to download.
2. Click on the "cloud with down arrow" button towards the upper right (to the right of your Model's name).
3. Select Ruby from the language dropdown, and the code for a Ruby method will appear.
4. Copy the code from the page and paste into your codebase where appropriate.
5. If you are using Hadoop, click on the "Hadoop ready" (elephant) button, select Ruby as the language to see Ruby code for use with Hadoop.

## Using big_ml gem
1. While logged into the BigML dashboard, click on your user name
2. Click on "API Key" on the left hand menu list to see your API key.
3. Add the [`big_ml`](https://github.com/vigosan/big_ml) ruby gem to your Gemfile, and follow Readme instructions, using you BigML username and API key to authenticate.
4. All of the things available in the UI are available via API.
5. Note that setting the configuration of `dev_mode` to true or false corresponds to whether the API client is working with the DEV sandbox or PROD mode.
6. The [API documentation](https://bigml.com.au/api/) is quite thorough and there are many endpoints not available through the gem, though forking the gem to include any endpoints you need is quite straightforward.
