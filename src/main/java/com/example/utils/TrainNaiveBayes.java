package com.example.utils;



import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.meta.FilteredClassifier;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.unsupervised.attribute.StringToWordVector;

import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

public class TrainNaiveBayes {

    public static void main(String[] args) {
        try {
            // Load the ARFF file
            DataSource source = new DataSource("/Users/olawale/Desktop/javacs/X-change/src/main/resources/dataset.arff");
            Instances data = source.getDataSet();

            // Set the class index (the attribute to be predicted)
            data.setClassIndex(data.numAttributes() - 1);

            // Create the StringToWordVector filter
            StringToWordVector filter = new StringToWordVector();
            filter.setAttributeIndices("2-last");

            // Create the NaiveBayes classifier
            NaiveBayes nb = new NaiveBayes();

            // Create the FilteredClassifier
            FilteredClassifier fc = new FilteredClassifier();
            fc.setFilter(filter);
            fc.setClassifier(nb);

            // Train the classifier
            fc.buildClassifier(data);

            // Save the model
            ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("/Users/olawale/Desktop/javacs/X-change/src/main/resources/NaiveBayes.model"));
            out.writeObject(fc);
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
