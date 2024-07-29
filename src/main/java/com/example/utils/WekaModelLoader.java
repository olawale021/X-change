package com.example.utils;


import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instances;

import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.util.ArrayList;

public class WekaModelLoader {

    private Classifier classifier;
    private ArrayList<Attribute> attributes;

    public WekaModelLoader(String modelPath) throws Exception {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(modelPath));
        classifier = (Classifier) ois.readObject();
        ois.close();
        initializeAttributes();
    }

    private void initializeAttributes() {
        attributes = new ArrayList<>();
        ArrayList<String> brandValues = new ArrayList<String>() {{
            add("IKEA");
            add("HP");
            add("LG");
            add("River_Island");
            add("DELL");
            add("Sony");
            add("Apple");
            add("ASUS");
            add("Samsung");
            add("Crayola");
            add("Nike");
            add("Whirlpool");
            add("Adidas");
            add("None");
        }};
        ArrayList<String> modelValues = new ArrayList<String>() {{
            add("Galaxy_S21");
            add("G5_15");
            add("iPhone_13_Pro_Max");
            add("WH-1000XM4");
            add("MacBook_Air");
            add("Spectre_x360");
            add("ROG_Strix");
            add("Ultra_One");
            add("None");
        }};
        ArrayList<String> typeValues = new ArrayList<String>() {{
            add("Wardrobe");
            add("Monitor");
            add("Laptop");
            add("Table");
            add("Jumper_Dress");
            add("Bookshelf");
            add("Top");
            add("Washer");
            add("Dryer");
            add("Phone");
            add("Camera");
            add("Vacuum_Cleaner");
            add("None");
        }};
        ArrayList<String> colourValues = new ArrayList<String>() {{
            add("Black");
            add("Grey");
            add("White");
            add("Blue");
            add("Red");
            add("Brown");
            add("Pink");
            add("Yellow");
            add("Silver");
            add("None");
        }};
        ArrayList<String> ramValues = new ArrayList<String>() {{
            add("8GB");
            add("16GB");
            add("32GB");
            add("None");
        }};
        ArrayList<String> sizeValues = new ArrayList<String>() {{
            add("S");
            add("M");
            add("L");
            add("XL");
            add("None");
        }};
        ArrayList<String> categoryValues = new ArrayList<String>() {{
            add("Furniture");
            add("Electronics");
            add("Clothing");
        }};

        attributes.add(new Attribute("Brand", brandValues));
        attributes.add(new Attribute("Model", modelValues));
        attributes.add(new Attribute("Type", typeValues));
        attributes.add(new Attribute("Colour", colourValues));
        attributes.add(new Attribute("RAM", ramValues));
        attributes.add(new Attribute("Size", sizeValues));
        attributes.add(new Attribute("Category", categoryValues));
    }

    public String predictCategory(String brand, String model, String type, String colour, String ram, String size) throws Exception {
        Instances data = new Instances("TestInstances", attributes, 0);
        data.setClassIndex(data.numAttributes() - 1);

        DenseInstance instance = new DenseInstance(data.numAttributes());
        instance.setValue(attributes.get(0), brand);
        instance.setValue(attributes.get(1), model);
        instance.setValue(attributes.get(2), type);
        instance.setValue(attributes.get(3), colour);
        instance.setValue(attributes.get(4), ram);
        instance.setValue(attributes.get(5), size);

        data.add(instance);

        double predictionIndex = classifier.classifyInstance(data.instance(0));
        return data.classAttribute().value((int) predictionIndex);
    }
}
