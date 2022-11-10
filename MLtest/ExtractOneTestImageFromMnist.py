
from keras.datasets import mnist
from matplotlib import pyplot
import numpy as np

#loading
(train_X, train_y), (test_X, test_y) = mnist.load_data()


#plotting
from matplotlib import pyplot

np.savetxt("handwrittenImage.txt",train_X[0])
print(type(train_X[0]))
    # pyplot.subplot(330 + 1 + i)
    # pyplot.imshow(train_X[i], cmap=pyplot.get_cmap('gray'))
    # pyplot.show()
    