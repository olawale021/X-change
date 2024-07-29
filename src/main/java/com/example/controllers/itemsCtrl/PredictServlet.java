package com.example.controllers.itemsCtrl;

import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.Classifier;
import weka.core.SerializationHelper;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.StringToWordVector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/predict")
public class PredictServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PredictServlet.class.getName());
    private Classifier naiveBayes;
    private StringToWordVector filter;
    private Instances filteredData;

    @Override
    public void init() throws ServletException {
        try {
            // Load the saved Naive Bayes model from the WEB-INF directory
            String modelPath = getServletContext().getRealPath("/WEB-INF/naiveBayes0.model");
            naiveBayes = (Classifier) SerializationHelper.read(modelPath);
            LOGGER.info("Naive Bayes model loaded successfully from " + modelPath);

            // Load sample data to initialize the filter from the WEB-INF directory
            String arffPath = getServletContext().getRealPath("/WEB-INF/items.arff");
            DataSource source = new DataSource(arffPath);
            Instances data = source.getDataSet();
            data.setClassIndex(0);

            // Initialize the StringToWordVector filter
            filter = new StringToWordVector();
            filter.setInputFormat(data);
            filteredData = Filter.useFilter(data, filter);
            filteredData.setClassIndex(0); // Set the class index after filtering
            LOGGER.info("StringToWordVector filter initialized successfully.");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error while loading model or initializing filter.", e);
            throw new ServletException("Error initializing servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Display the form
        request.getRequestDispatcher("/input.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the item title and features from the request
            String itemTitle = request.getParameter("itemTitle");
            String itemFeatures = request.getParameter("itemFeatures");

            if (itemTitle == null || itemFeatures == null) {
                throw new ServletException("ItemTitle or ItemFeatures is missing from the request.");
            }

            // Manually create a new instance with the input data
            ArrayList<Attribute> attributes = new ArrayList<>();
            attributes.add(new Attribute("ItemTitle", (ArrayList<String>) null));
            attributes.add(new Attribute("ItemFeatures", (ArrayList<String>) null));
            attributes.add(new Attribute("Category", new ArrayList<String>(
                    Arrays.asList("Books", "Furniture", "Electronics", "Clothing", "Toys", "Appliances"))));

            Instances instanceSet = new Instances("TestInstances", attributes, 0);
            instanceSet.setClassIndex(2); // Assuming 'Category' is the class attribute

            double[] values = new double[instanceSet.numAttributes()];
            values[instanceSet.attribute("ItemTitle").index()] = instanceSet.attribute("ItemTitle").addStringValue(itemTitle);
            values[instanceSet.attribute("ItemFeatures").index()] = instanceSet.attribute("ItemFeatures").addStringValue(itemFeatures);

            instanceSet.add(new DenseInstance(1.0, values));
            Instances filteredInstanceSet = Filter.useFilter(instanceSet, filter);
            filteredInstanceSet.setClassIndex(0);

            // Make a prediction
            double classLabel = naiveBayes.classifyInstance(filteredInstanceSet.firstInstance());
            String predictedClass = filteredInstanceSet.classAttribute().value((int) classLabel); //set first instance as class attribute

            // Set the predicted class as a request attribute and forward to the same JSP
            request.setAttribute("predictedClass", predictedClass);
            request.getRequestDispatcher("/input.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error while making prediction.", e);
            throw new ServletException("Error making prediction", e);
        }
    }
}
