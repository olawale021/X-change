<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Item</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/style.css' />">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f8ff;
        }
        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            width: 200px;
            height: 100%;
            background-color: #14397d;
            padding-top: 20px;
            border-right: 1px solid #dee2e6;
        }
        .sidebar a {
            display: block;
            color: #ffffff;
            padding: 10px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar a:hover {
            background-color: #ffffff;
            color: #14397d;
        }
        .main-content {
            margin-left: 210px;
            padding: 20px;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #14397d;
            color: white;
        }
        .btn-primary {
            background-color: #14397d;
            border-color: #14397d;
        }
        .btn-primary:hover {
            background-color: #0e2b5c;
            border-color: #0e2b5c;
        }
        #imagePreview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .image-preview-item {
            position: relative;
            width: 150px;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .image-preview-item .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 50%;
            padding: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            background-color: #f8f9fa;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .custom-file-upload:hover {
            background-color: #e2e6ea;
        }
        #images {
            display: none;
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h2><i class="fas fa-plus-circle"></i> Add New Item</h2>
            </div>
            <div class="card-body">
                <form action="<c:url value='/additem' />" method="post" enctype="multipart/form-data" id="addItemForm">
                    <div class="form-group">
                        <label for="title"><i class="fas fa-heading"></i> Item Title:</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="description"><i class="fas fa-align-left"></i> Description:</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="categoryId"><i class="fas fa-tag"></i> Category:</label>
                        <select class="form-control" id="categoryId" name="categoryId" required>
                            <option value="" disabled selected>Select Category</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editCondition">Condition</label>
                        <select class="form-control" id="editCondition" name="condition" required>
                            <option value="New">New</option>
                            <option value="Like New">Like New</option>
                            <option value="Good">Good</option>
                            <option value="Fair">Fair</option>
                            <option value="Poor">Poor</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="itemFeatures"><i class="fas fa-heading"></i> Item Feature:</label>
                        <input type="text" class="form-control" id="itemFeatures" name="itemFeatures" required>
                    </div>
                    <div class="form-group">
                        <label for="images"><i class="fas fa-images"></i> Images:</label>
                        <label for="images" class="custom-file-upload">
                            <i class="fas fa-cloud-upload-alt"></i> Choose Images
                        </label>
                        <input type="file" id="images" name="images" multiple accept="image/*" required>
                        <div id="imagePreview"></div>
                    </div>
                    <input type="hidden" name="userId" value="${sessionScope.user.id}">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus-circle"></i> Add Item</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <jsp:include page="footer.jsp" />
</footer>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    let filesArray = []; // Array to store files

    document.getElementById('images').addEventListener('change', function(event) {
        var preview = document.getElementById('imagePreview');
        var files = event.target.files;

        for (var i = 0; i < files.length; i++) {
            filesArray.push(files[i]);
            var file = files[i];
            var reader = new FileReader();

            reader.onload = (function(file) {
                return function(e) {
                    var div = document.createElement('div');
                    div.className = 'image-preview-item';
                    div.innerHTML =
                        '<img src="' + e.target.result + '" alt="Image preview" />' +
                        '<span class="remove-image" onclick="removeImage(' + (filesArray.length - 1) + ', this)"><i class="fas fa-times"></i></span>';
                    preview.appendChild(div);
                };
            })(file);

            reader.readAsDataURL(file);
        }
    });

    function removeImage(index, element) {
        filesArray.splice(index, 1);
        var preview = document.getElementById('imagePreview');
        var newFiles = new DataTransfer();

        filesArray.forEach(function(file) {
            newFiles.items.add(file);
        });

        document.getElementById('images').files = newFiles.files;
        preview.removeChild(element.parentElement);
    }

    document.getElementById('addItemForm').addEventListener('submit', function(event) {
        var imagePreview = document.getElementById('imagePreview');
        if (imagePreview.children.length === 0) {
            event.preventDefault();
            alert('Please select at least one image for the item.');
        }
    });
</script>
</body>
</html>
