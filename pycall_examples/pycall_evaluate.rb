require 'pycall/import'
include PyCall::Import

# http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html
pyfrom 'sklearn.model_selection', import: :train_test_split
# http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html
pyfrom 'sklearn.neighbors', import: :KNeighborsClassifier
pyfrom 'sklearn', import: :datasets

def train(features, target, model_options)
  model = KNeighborsClassifier.new(model_options)
  model.fit(features, target)
  return model
end

def evaluate(model, x_test, y_test)
  model.score(x_test, y_test)
end

# make a random classification dataset
# http://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_classification.html
# the default is 100 examples
features, outputs = *datasets.make_classification()

features_train, features_test, output_train, output_test = train_test_split(features, outputs, test_size: 0.4)

neighbour_values = [1,2,3,4,5,6,7,8,9,10]
weight_values = %w(uniform distance)
neighbour_values.each do |neighbour_value|
  weight_values.each do |weight_value|
    model = train(features_train, output_train, {n_neighbors: neighbour_value, weights: weight_value})
    mean_accuracy = model.score(features_test, output_test)
    puts "For #{neighbour_value} neighbors, #{weight_value} weighting, the mean accuracy is: #{mean_accuracy}."
  end
end
