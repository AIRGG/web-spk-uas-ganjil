import numpy as np

# MABAC
from pyDecision.algorithm import mabac_method

# MABAC

# Load Criterion Type: 'max' or 'min'
criterion_type = ['max', 'max', 'min', 'max', 'max', 'min']

# Dataset
dataset = np.array([
    [6,5,2,4,7,5,9,6,4,3],
    [4,3,5,1,3,4,3,2,5,2],
    [26,21,27,24,28,23,22,26,22,22],
    [48,24,36,36,60,24,60,48,24,24],
    [24,8,12,8,24,8,8,24,8,6],
    [55,60,55,65,65,55,65,60,50,60],  
])
print(dataset)
T = np.transpose(dataset)
print(T)
rank = mabac_method(T, criterion_type)
print(rank)