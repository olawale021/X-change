<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Items - MangoEx</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #f8f9fa;
            --accent-color: #28a745;
            --text-color: #333;
            --light-text-color: #6c757d;
        }

        body {
            font-family: 'Roboto', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
            background-color: var(--secondary-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .sidebar {
            position: fixed;
            top: 56px;
            left: 0;
            width: 220px;
            height: calc(100vh - 56px);
            background-color: var(--primary-color);
            padding-top: 20px;
            border-right: 1px solid #dee2e6;
            z-index: 1000;
            overflow-y: auto;
            transition: all 0.3s ease;
        }

        .sidebar a {
            display: block;
            color: #ffffff;
            padding: 12px 20px;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidebar a:hover, .sidebar a:focus, .sidebar a.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border-left-color: var(--accent-color);
        }

        .sidebar i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .main-content {
            margin-left: 220px;
            padding: 30px;
            padding-bottom: 60px;
        }

        .card {
            margin-bottom: 25px;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card-body {
            padding: 25px;
        }

        .item-widget {
            display: flex;
            align-items: flex-start;
            gap: 25px;
        }

        .item-img {
            flex: 0 0 200px;
        }

        .item-img img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .item-details {
            flex: 1;
        }

        .item-actions {
            flex: 0 0 150px;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        .item-name {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--primary-color);
        }

        .item-description {
            font-size: 16px;
            margin-bottom: 12px;
            color: var(--text-color);
        }

        .item-category,
        .item-condition {
            font-size: 14px;
            color: var(--light-text-color);
            margin-bottom: 6px;
        }

        .rating {
            margin-bottom: 12px;
        }

        .rating .fas {
            color: #ffc107;
        }

        .btn-action {
            margin-bottom: 10px;
            padding: 8px 15px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 5px;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-view {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        .btn-edit {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: white;
        }

        .btn-delete {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 0;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
        }

        .image-preview {
            display: inline-block;
            position: relative;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .image-preview img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 50%;
            padding: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .modal-content {
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            background-color: var(--primary-color);
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 20px;
        }

        .modal-body {
            padding: 30px;
        }

        .form-control {
            border-radius: 5px;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(20, 57, 125, 0.25);
        }
    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<!-- Sidebar -->
<div class="sidebar">
    <a href="<c:url value='/user-dashboard.jsp' />"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    <a href="<c:url value='/my-items.jsp' />"><i class="fas fa-box-open"></i> My Items</a>
    <a href="<c:url value='/add-item.jsp' />"><i class="fas fa-plus-circle"></i> Add Item</a>
    <a href="<c:url value='/exchanged-items.jsp' />"><i class="fas fa-exchange-alt"></i> Exchanged Items</a>
    <a href="<c:url value='/pending-requests.jsp' />"><i class="fas fa-clock"></i> Pending Requests</a>
    <a href="<c:url value='/edit-profile.jsp' />"><i class="fas fa-user-edit"></i> Edit Profile</a>
    <a href="<c:url value='/logout' />"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="container-fluid">
        <h1 class="mb-4">My Items</h1>
        <div class="row">
            <div class="col-12">
                <c:if test="${empty items}">
                    <div class="alert alert-info" role="alert">
                        You haven't posted any items yet. <a href="<c:url value='/add-item.jsp' />" class="alert-link">Add an item</a> to get started!
                    </div>
                </c:if>
                <c:forEach var="item" items="${items}">
                    <div class="card">
                        <div class="card-body">
                            <div class="item-widget">
                                <div class="item-img">
                                    <img src="<c:out value='${item.firstPhotoUrl}' />" alt="Item Image">
                                </div>
                                <div class="item-details">
                                    <h5 class="item-name"><c:out value="${item.title}" /></h5>
                                    <p class="item-description"><c:out value="${item.description}" /></p>
                                    <p class="item-category"><strong>Category:</strong> <c:out value="${item.categoryName}" /></p>
                                    <p class="item-condition"><strong>Condition:</strong> <c:out value="${item.condition}" /></p>
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                                <div class="item-actions">
                                    <a class="btn btn-action btn-view" href="<c:url value='/item-detail?id=${item.id}' />">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <button class="btn btn-action btn-edit" onclick="openEditModal(this)"
                                            data-id="${item.id}"
                                            data-title="${item.title}"
                                            data-description="${item.description}"
                                            data-condition="${item.condition}"
                                            data-category="${item.categoryId}"
                                            data-photos="<c:out value='${fn:escapeXml(item.photosJson)}' />">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>

                                    <button class="btn btn-action btn-delete" onclick="confirmDelete(${item.id})">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- Edit Item Modal -->
<div class="modal fade" id="editItemModal" tabindex="-1" role="dialog" aria-labelledby="editItemModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editItemModalLabel">Edit Item</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editItemForm" action="<c:url value='/update-item'/>" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="editItemId" name="itemId">
                    <div class="form-group">
                        <label for="editTitle">Title</label>
                        <input type="text" class="form-control" id="editTitle" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editCategory">Category</label>
                        <select class="form-control" id="editCategory" name="categoryId" required>
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
                        <label>Current Images</label>
                        <div id="currentImages" class="image-preview-container"></div>
                    </div>
                    <div class="form-group">
                        <label for="newImages">Add New Images</label>
                        <input type="hidden" id="existingPhotosJson" name="existingPhotosJson">
                        <input type="file" class="form-control-file" id="newImages" name="newImages" multiple accept="image/*">
                    </div>
                    <div id="newImagePreviews" class="image-preview-container"></div>
                    <button type="submit" class="btn btn-primary">Update Item</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <jsp:include page="footer.jsp" />
</footer>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function confirmDelete(itemId) {
        if (confirm('Are you sure you want to delete this item?')) {
            window.location.href = '<c:url value="/delete-item?id=" />' + itemId;
        }
    }

    function openEditModal(button) {
        const itemId = $(button).data('id');
        const title = $(button).data('title');
        const description = $(button).data('description');
        const condition = $(button).data('condition');
        const categoryId = $(button).data('category');
        let photosJson = $(button).attr('data-photos'); // Retrieve photos JSON

        console.log("Opening edit modal with data:");
        console.log("itemId:", itemId);
        console.log("title:", title);
        console.log("description:", description);
        console.log("condition:", condition);
        console.log("categoryId:", categoryId);
        console.log("photosJson:", photosJson);

        // Decode HTML entities in the photosJson string
        photosJson = decodeHtml(photosJson);

        $('#editItemId').val(itemId);
        $('#editTitle').val(title);
        $('#editDescription').val(description);
        $('#editCategory').val(categoryId);
        $('#editCondition').val(condition);
        $('#existingPhotosJson').val(photosJson); // Set existing photos

        // Display current images
        const currentImagesContainer = $('#currentImages');
        currentImagesContainer.empty();

        try {
            const photos = JSON.parse(photosJson);
            console.log("Parsed photos:", photos);
            photos.forEach((photo, index) => {
                if(photo) { // Ensure photo is not an empty string
                    const imagePreview = $('<div class="image-preview">' +
                        '<img src="' + photo + '" alt="Item Image">' +
                        '<span class="remove-image" onclick="removeCurrentImage(' + index + ')"><i class="fas fa-times"></i></span>' +
                        '</div>');
                    currentImagesContainer.append(imagePreview);
                }
            });
        } catch (e) {
            console.error("Error parsing photosJson:", e);
            alert('Failed to load item images. Please try again later.');
        }

        $('#editItemModal').modal('show');
    }

    // Function to decode HTML entities
    function decodeHtml(html) {
        const txt = document.createElement('textarea');
        txt.innerHTML = html;
        return txt.value;
    }

    function removeCurrentImage(index) {
        $($('#currentImages .image-preview')[index]).remove();
    }

    $('#newImages').on('change', function(event) {
        const newImagePreviews = $('#newImagePreviews');
        newImagePreviews.empty();
        const files = event.target.files;

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function(e) {
                const imagePreview = $('<div class="image-preview">' +
                    '<img src="' + e.target.result + '" alt="New Image">' +
                    '<span class="remove-image" onclick="removeNewImage(this)"><i class="fas fa-times"></i></span>' +
                    '</div>');
                newImagePreviews.append(imagePreview);
            };

            reader.readAsDataURL(file);
        }
    });

    function removeNewImage(element) {
        $(element).closest('.image-preview').remove();
    }

    $('#editItemModal').on('hide.bs.modal', function (e) {
        if ($('#editItemForm').data('submitting')) {
            e.preventDefault();
        }
    });

    $('#editItemForm').on('submit', function(e) {
        $(this).data('submitting', true);
    });


</script>
</body>
</html>
