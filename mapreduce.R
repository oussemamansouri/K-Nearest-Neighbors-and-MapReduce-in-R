# Charger les packages nécessaires
library(class)
library(datasets)
library(ggplot2)

# Charger le jeu de données Iris
data(iris)

# 1. Définir la fonction Map qui va mapper les données (simuler le MapReduce)
map_function <- function(data) {
  keyval_list <- lapply(1:nrow(data), function(i) {
    keyval(data[i, 5], data[i, 1:4])  # Utiliser la classe comme clé et les caractéristiques comme valeur
  })
  keyval_list
}

# 2. Définir la fonction Reduce qui va réduire les résultats
reduce_function <- function(keyval_list) {
  reduced_data <- lapply(keyval_list, function(kv) {
    list(class = kv[[1]], values = kv[[2]])
  })
  return(reduced_data)
}

# 3. Appliquer la fonction Map et Reduce localement sur le jeu de données Iris
map_result <- map_function(iris)
reduced_result <- reduce_function(map_result)

# Affichage des résultats de MapReduce simulé
cat("Résultats de MapReduce simulé :\n")
print(reduced_result)

# 4. Fonction pour appliquer KNN et calculer l'exactitude
knn_accuracy <- function(train_data, test_data, train_labels, test_labels, k = 4) {
  predictions <- knn(train = train_data, test = test_data, cl = train_labels, k = k)
  accuracy <- sum(predictions == test_labels) / length(test_labels)
  return(accuracy)
}

# 5. Créer des sous-ensembles à partir du jeu de données pour KNN
create_subsets <- function(data, ratio = 0.7) {
  set.seed(123)
  shuffled_indices <- sample(1:nrow(data), size = nrow(data), replace = FALSE)
  train_size <- floor(ratio * nrow(data))
  train_indices <- shuffled_indices[1:train_size]
  test_indices <- shuffled_indices[(train_size + 1):nrow(data)]
  
  train_data <- data[train_indices, -5]
  train_labels <- data[train_indices, 5]
  test_data <- data[test_indices, -5]
  test_labels <- data[test_indices, 5]
  
  return(list(train_data = train_data, train_labels = train_labels, test_data = test_data, test_labels = test_labels))
}

# 6. Appliquer KNN pour chaque sous-ensemble généré
mapreduce_results <- data.frame(Subset = integer(), Accuracy = numeric())

for (i in 1:5) {
  subsets <- create_subsets(iris, ratio = 0.7)
  accuracy <- knn_accuracy(subsets$train_data, subsets$test_data, 
                           subsets$train_labels, subsets$test_labels, k = 4)
  mapreduce_results <- rbind(mapreduce_results, data.frame(Subset = i, Accuracy = accuracy))
}

# Affichage des résultats de MapReduce simulé
cat("Tableau des exactitudes pour chaque sous-ensemble MapReduce simulé :\n")
print(mapreduce_results)

# 7. Appliquer le KNN standard pour l'ensemble entier
subsets_standard <- create_subsets(iris, ratio = 0.7)
standard_accuracy <- knn_accuracy(subsets_standard$train_data, subsets_standard$test_data, 
                                  subsets_standard$train_labels, subsets_standard$test_labels, k = 3)

cat("Exactitude du KNN standard : ", standard_accuracy, "\n")

# Comparaison des résultats
comparison_results <- data.frame(Method = c("MapReduce KNN", "Standard KNN"), 
                                 Accuracy = c(mean(mapreduce_results$Accuracy), standard_accuracy))

cat("Comparaison des exactitudes :\n")
print(comparison_results)

# --- Visualisation des résultats ---
comparison_results_long <- data.frame(
  Method = rep(c("MapReduce KNN", "Standard KNN"), each = nrow(mapreduce_results)),
  Accuracy = c(mapreduce_results$Accuracy, rep(standard_accuracy, nrow(mapreduce_results)))
)


# Charger la librairie lattice
library(lattice)

# Assurez-vous que comparison_results est déjà défini
# comparison_results <- data.frame(Method = c("MapReduce KNN", "Standard KNN"),
#                                  Accuracy = c(mean(mapreduce_results$Accuracy), standard_accuracy))

# Créer le boxplot avec lattice
bwplot(Accuracy ~ Method, data = comparison_results,
       xlab = "Méthode", ylab = "Exactitude", 
       main = "Comparaison des performances KNN avec et sans MapReduce",
       col = c("lightblue", "lightgreen"))

# Créer un barplot avec base R
barplot(comparison_results$Accuracy,
        names.arg = comparison_results$Method,
        col = c("lightblue", "lightgreen"),
        main = "Comparaison des performances KNN avec et sans MapReduce",
        xlab = "Méthode", ylab = "Exactitude",
        border = "white")




