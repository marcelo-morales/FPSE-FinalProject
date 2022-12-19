
from keras.datasets import mnist

import numpy as np
np.set_printoptions(suppress=True)
#loading
(train_X, train_y), (test_X, test_y) = mnist.load_data()


#plotting
import matplotlib.pyplot as plt
import random


def fix(hey):
    hey[hey==0]=0
    hey[hey==0]=0


def sampleImage(numtimes):
    
    numberOfImages=[]

    for i in range(numtimes):
        temp=train_X[random.randint(0,10000)].astype(float)
        fix(temp)
        numberOfImages.append(temp)
    
    combined=np.hstack(numberOfImages)

    plt.imshow(combined)

    plt.savefig("../tests/data/0000")
    np.savetxt("../tests/data/0000.txt",combined,fmt='%19.2f')    

    

sampleImage(10)





# print(np.hstack((selectedImage1,selectedImage2)))





# print(selectedImage)

