# Charger les bibliothèques nécessaires
library(class)  # Pour l'algorithme k-NN

# Charger le jeu de données Iris
data <- iris

# Prétraitement : Normalisation des données
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
data_normalized <- as.data.frame(lapply(data[, 1:4], normalize))
data_normalized$Species <- data$Species

# Division des données en train/test
set.seed(123)
train_index <- sample(1:nrow(data_normalized), 0.7 * nrow(data_normalized))
train_data <- data_normalized[train_index, ]
test_data <- data_normalized[-train_index, ]

# Construire le modèle k-NN
k <- 5  # Nombre de voisins
knn_model <- knn(
  train = train_data[, 1:4],
  test = test_data[, 1:4],
  cl = train_data$Species,
  k = k
)

# Ajouter les prédictions au jeu de données de test
test_data$Predicted <- knn_model

# Matrice de confusion
confusion_matrix <- table(Actual = test_data$Species, Predicted = test_data$Predicted)
cat("Matrice de confusion :\n")
print(confusion_matrix)

# Calcul de la précision
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Précision du modèle :", round(accuracy * 100, 2), "%\n")

# Visualisation des prédictions (Graphiques de Base)

# 1. Distribution des prédictions par espèce
barplot(table(test_data$Predicted), col = c("red", "green", "blue"),
        main = "Distribution des Prédictions",
        xlab = "Espèce Prédite", ylab = "Nombre d'Échantillons")

# 2. Scatter plot des dimensions des pétales
plot(test_data$Petal.Length, test_data$Petal.Width, col = as.numeric(test_data$Predicted),
     pch = 19, xlab = "Longueur des Pétales", ylab = "Largeur des Pétales",
     main = "Prédictions k-NN : Dimensions des Pétales")
legend("topright", legend = levels(test_data$Species), col = 1:3, pch = 19)

# 3. Comparaison entre classes réelles et prédites
plot(test_data$Sepal.Length, test_data$Sepal.Width, col = as.numeric(test_data$Species),
     pch = 17, xlab = "Longueur des Sépales", ylab = "Largeur des Sépales",
     main = "Classes Réelles : Dimensions des Sépales")
points(test_data$Sepal.Length, test_data$Sepal.Width, col = as.numeric(test_data$Predicted),
       pch = 19)
legend("topright", legend = c("Réel", "Prédit"), col = c("black", "red"), pch = c(17, 19))





