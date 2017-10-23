# USAGE: ruby pycall_classification_example.rb
require 'dotenv/load'
require 'pycall/import'
include PyCall::Import

# This file is slightly modified and annotated from the example from PyCall gem, to work with the latest sklearn library
# https://github.com/mrkn/pycall.rb/blob/master/examples/classifier_comparison.rb
# The mrkn's inspiration for this script can be found here:
# http://scikit-learn.org/stable/auto_examples/classification/plot_classifier_comparison.html

pyimport 'numpy', as: :np
pyfrom 'sklearn.model_selection', import: :train_test_split
pyfrom 'sklearn.preprocessing', import: :StandardScaler
pyfrom 'sklearn.datasets', import: %i(make_moons make_circles make_classification)
pyfrom 'sklearn.neighbors', import: :KNeighborsClassifier
pyfrom 'sklearn.svm', import: :SVC
pyfrom 'sklearn.tree', import: :DecisionTreeClassifier
pyfrom 'sklearn.ensemble', import: %i(RandomForestClassifier AdaBoostClassifier)
pyfrom 'sklearn.naive_bayes', import: :GaussianNB
pyfrom 'sklearn.discriminant_analysis', import: %i(LinearDiscriminantAnalysis QuadraticDiscriminantAnalysis)

pyimport 'matplotlib', as: :mp

mp.use('agg')

pyimport 'matplotlib.pyplot', as: :plt
pyimport 'matplotlib.colors', as: :mplc

h = 0.02  # step size in the mesh

# The names of classifiers to examine
names = [
  'Nearest Neighbors',
  'Linear SVM',
  'RBF SVM',
  'Decision Tree',
  'Random Forest',
  'AdaBoost',
  'Naive Bayes',
  'Linear Discriminant Analysis',
  'Quadratic Discriminant Analysis'
]

# The classifiers themselves
classifiers = [
  KNeighborsClassifier.new(3),
  SVC.new(kernel: 'linear', C: 0.025),
  SVC.new(gamma: 2, C: 1),
  DecisionTreeClassifier.new(max_depth: 5),
  RandomForestClassifier.new(max_depth: 5, n_estimators: 10, max_features: 1),
  AdaBoostClassifier.new(),
  GaussianNB.new(),
  LinearDiscriminantAnalysis.new(),
  QuadraticDiscriminantAnalysis.new()
]


# Creating our linearly separable dataset of clustered data.
# Example data in x with two features, and y are the classification values.
# read about make_classification here:
# http://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_classification.html
x, y = *make_classification(
  n_features: 2,
  n_redundant: 0,
  n_informative: 2,
  random_state: 1,
  n_clusters_per_class: 1
)

np.random.seed(42)
x += 2 * np.random.random_sample(x.shape)
linearly_separable = PyCall.tuple([x, y]) # FIXME: allow PyCall.tuple(x, y)

# Our three datasets we will classify
# make_moons: http://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_moons.html
# make_circles: http://scikit-learn.org/stable/modules/generated/sklearn.datasets.make_circles.html
datasets = [
  make_moons(noise: 0.3, random_state: 0),
  make_circles(noise: 0.2, factor: 0.5, random_state: 1),
  linearly_separable
]

# matplotlib.figure: http://matplotlib.org/api/figure_api.html#matplotlib.figure
fig = plt.figure(figsize: [27, 9])
i = 1

# this constant is used in place of colon operator for vector operations.
all = 0..-1

# iterate over datasets
datasets.each do |ds|
  # preprocess dataset, split into training and test part
  x, y = *ds
  # standardise, scale values
  # http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html
  x = StandardScaler.new.fit_transform(x)
  # Split into training set and test set (40%)
  # http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html
  x_train, x_test, y_train, y_test = train_test_split(x, y, test_size: 0.4)

  # figure out max and min values for x axis and y axis of plots
  x_min, x_max = np.min(x[all, 0]) - 0.5, np.max(x[all, 0]) + 0.5
  y_min, y_max = np.min(x[all, 1]) - 0.5, np.max(x[all, 1]) + 0.5

  # mesh points which classify on, to determine the classification boundaries and shade plot accordingly
  # https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.meshgrid.html
  xx, yy = np.meshgrid(
    # https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.linspace.html
    np.linspace(x_min, x_max, ((x_max - x_min)/h).round),
    np.linspace(y_min, y_max, ((y_max - y_min)/h).round),
  )
  mesh_points = np.dstack(PyCall.tuple([xx.ravel(), yy.ravel()]))[0, all, all]

  # just plot the dataset first - first plot in each row is just the dataset
  # cm is colourmap for shading, red to blue
  cm = plt.cm.__dict__[:RdBu]
  # first category class will be red dots, second category class blue dots
  cm_bright = mplc.ListedColormap.new(["#FF0000", "#0000FF"])
  # http://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.subplot
  ax = plt.subplot(datasets.length, classifiers.length + 1, i)
  # plot the training points in scatter plot
  ax.scatter(x_train[all, 0], x_train[all, 1], c: y_train, cmap: cm_bright)
  # and testing points - 60% saturation
  ax.scatter(x_test[all, 0], x_test[all, 1], c: y_test, cmap: cm_bright, alpha: 0.6)

  ax.set_xlim(np.min(xx), np.max(xx))
  ax.set_ylim(np.min(yy), np.max(yy))
  ax.set_xticks(PyCall.tuple())
  ax.set_yticks(PyCall.tuple())
  i += 1

  # iterate over classifiers
  names.zip(classifiers).each do |name, clf|
    # http://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.subplot
    ax = plt.subplot(datasets.length, classifiers.length + 1, i)
    # Fit the model using training data and target values
    clf.fit(x_train, y_train)
    # Mean accuracy on the given test data and labels
    scor = clf.score(x_test, y_test)

    # Plot the decision boundary.  For that, we will assign a color to each
    # point in the mesh [x_min, x_max]x[y_min, y_max]
    begin
      # decision_function not implemented for some classifiers
      # Distance of the samples to the separating hyperplane
      z = clf.decision_function(mesh_points)
    rescue
      # predict_proba: probability estimates for the test data
      z = clf.predict_proba(mesh_points)[all, 1]
    end

    # Put the result into a color plot, using colourmap, 80% saturation
    # https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.reshape.html
    z = z.reshape(xx.shape)
    ax.contourf(xx, yy, z, cmap: cm, alpha: 0.8)

    # Plot also the training points
    ax.scatter(x_train[all, 0], x_train[all, 1], c: y_train, cmap: cm_bright)
    # and testing points
    ax.scatter(x_test[all, 0], x_test[all, 1], c: y_test, cmap: cm_bright, alpha: 0.6)

    ax.set_xlim(np.min(xx), np.max(xx))
    ax.set_ylim(np.min(yy), np.max(yy))
    ax.set_xticks(PyCall.tuple())
    ax.set_yticks(PyCall.tuple())
    # set the title of plot as classifier name
    ax.set_title(name)

    # Put the accuracy on the plot.
    ax.text(np.max(xx) - 0.3, np.min(yy) + 0.3, "%.2f" % scor, size: 15, horizontalalignment: 'right')

    i += 1
  end
end

fig.subplots_adjust(left: 0.02, right: 0.98)
plt.savefig('comparison.png')
