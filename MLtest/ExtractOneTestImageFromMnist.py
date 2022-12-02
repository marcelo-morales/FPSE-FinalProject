
from keras.datasets import mnist

import numpy as np
np.set_printoptions(suppress=True)
#loading
(train_X, train_y), (test_X, test_y) = mnist.load_data()


#plotting
import matplotlib.pyplot as plt


# np.savetxt("handwrittenImage.txt",train_X[0])
print(type(test_X[0]))
print(test_X[0].dtype)
print(test_X[0].dtype.byteorder)
    # pyplot.subplot(330 + 1 + i)
    # pyplot.imshow(train_X[i], cmap=pyplot.get_cmap('gray'))
    # pyplot.show()
    

selectedImage=test_X[2].astype(float)
print(selectedImage.dtype)
print(selectedImage.dtype.byteorder)

selectedImage[selectedImage==0]=0
selectedImage[selectedImage!=0]=1
# print(selectedImage)

np.savetxt("handwrittenImage.txt",selectedImage,fmt='%19.2f')
np.savez("handwrittenImage",selectedImage)
np.save("handwrittenImage",selectedImage)

print(selectedImage)
plt.imshow(selectedImage)
plt.savefig("selectedImageshow")


