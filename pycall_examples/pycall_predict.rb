# USAGE: ruby pycall_predict.rb <name of csv of iris data to predict on>
# iris data to predict on csv columns should be: Sepal Length, Sepal Width, Petal Length and Petal Width.
require 'csv'
require 'pycall/import'
include PyCall::Import

# http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html
pyfrom 'sklearn.model_selection', import: :train_test_split
# http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html
pyfrom 'sklearn.neighbors', import: :KNeighborsClassifier
pyfrom 'sklearn', import: :datasets

pyfrom 'sklearn.externals', import: :joblib

def train(features, target, model_options)
  model = KNeighborsClassifier.new(model_options)
  model.fit(features, target)
  return model
end

# load csv data for training
# assumes presence of headers and the last column values is target
def load_and_train(csv_file_name, model_options)
  input_data = CSV.read(csv_file_name, headers: true)
  num_fields = input_data[0].length

  # last column is target
  # all other are features
  target = input_data.map{|a| a[num_fields-1]}
  features = input_data.map{|a| a.fields((0...num_fields-1))}

  return train(features, target, model_options)
end

# if you want to save the model to a file to use elsewhere
def persist_model(model)
  joblib.dump(model, 'model.pkl')
  model = joblib.load('model.pkl')
  return model
end

# load the csv to predict
csv_file_name = ARGV[0]
input_to_predict = CSV.read(csv_file_name)

# load training data from sklearn
data = datasets.load_iris()

# classes => ['setosa', 'versicolor', 'virginica']
classes = data.target_names

model = train(data.data, data.target, {n_neighbors: 3})

# optional: call persist_model to save it to file and load it
# model = persist_model(model)

predictions = model.predict(input_to_predict)

# Convert python predictions to PyCall List
# And ten convert to Array for easy iterating.
predictions = PyCall::List.new(predictions).to_a
predictions.each_with_index do |prediction, i|
  puts "Row #{i+1}: #{classes[prediction]}"
end

puts "Now using csv data for training!"
# Here we load csv training data to create model
model_from_csv = load_and_train('iris_training.csv', {n_neighbors: 3})
csv_predictions = model_from_csv.predict(input_to_predict)

# Convert python predictions to PyCall List
# And ten convert to Array for easy iterating.
csv_predictions = PyCall::List.new(csv_predictions).to_a
csv_predictions.each_with_index do |prediction, i|
  puts "Row #{i+1}: #{prediction}"
end
