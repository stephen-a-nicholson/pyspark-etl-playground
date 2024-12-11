"""Runs transformations on dataset"""

import kagglehub
from pyspark.sql import SparkSession
from pyspark.sql import functions as f


def main():
    path = kagglehub.dataset_download("subhajournal/movie-rating")
    print("Path to dataset files:", path)
    spark: SparkSession = (
        SparkSession.builder.master("local").appName("Word Count").getOrCreate()
    )
    movie_reviews = spark.read.csv(path=path, header=True)
    print(movie_reviews.head())

    movie_reviews.select("*").filter(f.col("audience_rating") > 77).show()


if __name__ == "__main__":
    main()
