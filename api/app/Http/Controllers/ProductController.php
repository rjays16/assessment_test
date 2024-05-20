<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function storeProduct(Request $request)
    {
        // Validate the request data
        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'due_date' => 'nullable|date',
            'status' => 'required|boolean',
        ]);

        $product = Product::create($validatedData);
        return response()->json($product, 201);
    }

    public function getAllProducts()
    {
        $products = Product::all();
        return response()->json($products, 200);
    }

    public function deleteProduct(Product $product)
    {
        $product->delete();
        return response()->json(['message' => 'Product deleted successfully'], 200);
    }
}
