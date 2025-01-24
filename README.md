# K-Nearest Neighbors and MapReduce in R

This repository contains two R scripts that demonstrate the implementation of the k-Nearest Neighbors (k-NN) algorithm and a simulated MapReduce workflow using the Iris dataset.

## Features

1. **`Knn.R`**:
   - Implements the k-NN algorithm for classification.
   - Normalizes the dataset for preprocessing.
   - Splits the dataset into training and testing sets.
   - Visualizes predictions and compares real vs. predicted classes.
   - Calculates accuracy and displays a confusion matrix.
   - Creates various visualizations (e.g., bar plots, scatter plots) to showcase results.

2. **`MapReduce.R`**:
   - Simulates a MapReduce workflow for processing the Iris dataset.
   - Implements custom Map and Reduce functions.
   - Demonstrates k-NN on subsets of the dataset generated using the simulated MapReduce process.
   - Compares the accuracy of k-NN using MapReduce subsets vs. the standard approach.
   - Visualizes accuracy comparisons using lattice and base R.

## Prerequisites

Before running the scripts, ensure you have R installed along with the following packages:
- `class`
- `datasets`
- `ggplot2`
- `lattice`

To install missing packages, use:
```r
install.packages(c("class", "ggplot2", "lattice"))
```

## Files in the Repository
- Knn.R: Contains the k-NN algorithm implementation and data visualization for the Iris dataset.
- MapReduce.R: Simulates MapReduce and compares k-NN results using subsets and the standard approach.

## How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/oussemamansouri/K-Nearest-Neighbors-and-MapReduce-in-R.git
   cd K-Nearest-Neighbors-and-MapReduce-in-R
   ```
2. Open R or RStudio and load the script:

   ```R
   source("Knn.R")
   # Or
   source("MapReduce.R")
   ```
3. Follow the on-screen instructions and view the results.

## Output Highlights

### Knn.R

- **Confusion Matrix**: Displays the model's accuracy in predicting species.
- **Accuracy**: Provides the percentage of correctly classified samples.
- **Visualizations**:
  - Distribution of predicted species.
  - Comparison of real vs. predicted classes.

### MapReduce.R

- **MapReduce Results**: Lists accuracy for subsets processed using the simulated MapReduce framework.
- **Accuracy Comparison**: Compares the performance of MapReduce-based k-NN and standard k-NN.
- **Visualizations**:
  - Boxplot of accuracy for the two methods.
  - Bar plot of accuracy comparison.

Happy coding! 🎉
