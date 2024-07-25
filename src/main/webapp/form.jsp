<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Classification</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a90e2;
            --secondary-color: #f5f7fa;
            --text-color: #333;
            --border-color: #e1e4e8;
        }
        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: var(--secondary-color);
            padding: 40px 0;
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }
        h1, h2 {
            color: var(--primary-color);
        }
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        form {
            display: grid;
            gap: 20px;
        }
        label {
            font-weight: 600;
            margin-bottom: 5px;
            display: block;
        }
        select, input[type="submit"], button {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        select:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        input[type="submit"], button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover, button:hover {
            background-color: #3a7cbd;
        }
        .prediction-result {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            text-align: center;
            z-index: 1000;
            width: 300px; /* Set a fixed width */
        }
        .prediction-result h2 {
            margin-top: 0;
            margin-bottom: 20px;
        }
        .prediction-result p {
            margin-bottom: 20px;
        }
        .prediction-result button {
            width: auto; /* Allow button to size to content */
            padding: 10px 20px;
            margin-top: 20px;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Item Classification</h1>
    <div class="card">
        <form action="classify" method="post">
            <div>
                <label for="brand">Brand:</label>
                <select name="brand" id="brand">
                    <option value="IKEA">IKEA</option>
                    <option value="HP">HP</option>
                    <option value="LG">LG</option>
                    <option value="River_Island">River Island</option>
                    <option value="DELL">DELL</option>
                    <option value="Sony">Sony</option>
                    <option value="Apple">Apple</option>
                    <option value="ASUS">ASUS</option>
                    <option value="Samsung">Samsung</option>
                    <option value="Crayola">Crayola</option>
                    <option value="Nike">Nike</option>
                    <option value="Whirlpool">Whirlpool</option>
                    <option value="Adidas">Adidas</option>
                    <option value="None">None</option>
                </select>
            </div>
            <div>
                <label for="model">Model:</label>
                <select name="model" id="model">
                    <option value="Galaxy_S21">Galaxy S21</option>
                    <option value="G5_15">G5 15</option>
                    <option value="iPhone_13_Pro_Max">iPhone 13 Pro Max</option>
                    <option value="WH-1000XM4">WH-1000XM4</option>
                    <option value="MacBook_Air">MacBook Air</option>
                    <option value="Spectre_x360">Spectre x360</option>
                    <option value="ROG_Strix">ROG Strix</option>
                    <option value="Ultra_One">Ultra One</option>
                    <option value="None">None</option>
                </select>
            </div>
            <div>
                <label for="type">Type:</label>
                <select name="type" id="type">
                    <option value="Wardrobe">Wardrobe</option>
                    <option value="Monitor">Monitor</option>
                    <option value="Laptop">Laptop</option>
                    <option value="Table">Table</option>
                    <option value="Jumper_Dress">Jumper Dress</option>
                    <option value="Bookshelf">Bookshelf</option>
                    <option value="Top">Top</option>
                    <option value="Washer">Washer</option>
                    <option value="Dryer">Dryer</option>
                    <option value="Phone">Phone</option>
                    <option value="Camera">Camera</option>
                    <option value="Vacuum_Cleaner">Vacuum Cleaner</option>
                    <option value="None">None</option>
                </select>
            </div>
            <div>
                <label for="colour">Colour:</label>
                <select name="colour" id="colour">
                    <option value="Black">Black</option>
                    <option value="Grey">Grey</option>
                    <option value="White">White</option>
                    <option value="Blue">Blue</option>
                    <option value="Red">Red</option>
                    <option value="Brown">Brown</option>
                    <option value="Pink">Pink</option>
                    <option value="Yellow">Yellow</option>
                    <option value="Silver">Silver</option>
                    <option value="None">None</option>
                </select>
            </div>
            <div>
                <label for="ram">RAM:</label>
                <select name="ram" id="ram">
                    <option value="8GB">8GB</option>
                    <option value="16GB">16GB</option>
                    <option value="32GB">32GB</option>
                    <option value="None">None</option>
                </select>
            </div>
            <div>
                <label for="size">Size:</label>
                <select name="size" id="size">
                    <option value="S">S</option>
                    <option value="M">M</option>
                    <option value="L">L</option>
                    <option value="XL">XL</option>
                    <option value="None">None</option>
                </select>
            </div>
            <input type="submit" value="Classify">
        </form>
    </div>

    <div id="resultOverlay" class="overlay hidden"></div>
    <div id="resultPopup" class="prediction-result hidden">
        <h2>Prediction Result</h2>
        <p>Predicted Category: <strong id="predictedCategory"></strong></p>
        <button onclick="hideResult()">Make Another Prediction</button>
    </div>

    <c:if test="${not empty predictedCategory}">
        <script>
            document.getElementById('predictedCategory').textContent = "${predictedCategory}";
            document.getElementById('resultOverlay').classList.remove('hidden');
            document.getElementById('resultPopup').classList.remove('hidden');
        </script>
    </c:if>
</div>

<script>
    function hideResult() {
        document.getElementById('resultOverlay').classList.add('hidden');
        document.getElementById('resultPopup').classList.add('hidden');
    }
</script>
</body>
</html>
