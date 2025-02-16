# Charger les biblioth�ques n�cessaires
library(class)  # Pour l'algorithme k-NN

# Charger le jeu de donn�es Iris
data <- iris

# Pr�traitement : Normalisation des donn�es
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
data_normalized <- as.data.frame(lapply(data[, 1:4], normalize))
data_normalized$Species <- data$Species

# Division des donn�es en train/test
set.seed(123)
train_index <- sample(1:nrow(data_normalized), 0.7 * nrow(data_normalized))
train_data <- data_normalized[train_index, ]
test_data <- data_normalized[-train_index, ]

# Construire le mod�le k-NN
k <- 5  # Nombre de voisins
knn_model <- knn(
  train = train_data[, 1:4],
  test = test_data[, 1:4],
  cl = train_data$Species,
  k = k
)

# Ajouter les pr�dictions au jeu de donn�es de test
test_data$Predicted <- knn_model

# Matrice de confusion
confusion_matrix <- table(Actual = test_data$Species, Predicted = test_data$Predicted)
cat("Matrice de confusion :\n")
print(confusion_matrix)

# Calcul de la pr�cision
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Pr�cision du mod�le :", round(accuracy * 100, 2), "%\n")

# Visualisation des pr�dictions (Graphiques de Base)

# 1. Distribution des pr�dictions par esp�ce
barplot(table(test_data$Predicted), col = c("red", "green", "blue"),
        main = "Distribution des Pr�dictions",
        xlab = "Esp�ce Pr�dite", ylab = "Nombre d'�chantillons")

# 2. Scatter plot des dimensions des p�tales
plot(test_data$Petal.Length, test_data$Petal.Width, col = as.numeric(test_data$Predicted),
     pch = 19, xlab = "Longueur des P�tales", ylab = "Largeur des P�tales",
     main = "Pr�dictions k-NN : Dimensions des P�tales")
legend("topright", legend = levels(test_data$Species), col = 1:3, pch = 19)

# 3. Comparaison entre classes r�elles et pr�dites
plot(test_data$Sepal.Length, test_data$Sepal.Width, col = as.numeric(test_data$Species),
     pch = 17, xlab = "Longueur des S�pales", ylab = "Largeur des S�pales",
     main = "Classes R�elles : Dimensions des S�pales")
points(test_data$Sepal.Length, test_data$Sepal.Width, col = as.numeric(test_data$Predicted),
       pch = 19)
legend("topright", legend = c("R�el", "Pr�dit"), col = c("black", "red"), pch = c(17, 19))





