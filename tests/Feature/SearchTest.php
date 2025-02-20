<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\Product;

class SearchTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function it_returns_search_results()
    {
        // Create some products
        Product::factory()->create(['title' => 'The Haunted Manor', 'description' => 'A chilling story of a haunted house.']);
        Product::factory()->create(['title' => 'Nightmares Unleashed', 'description' => 'Terrifying tales of the unknown.']);
        Product::factory()->create(['title' => 'Whispers in the Dark', 'description' => 'What hides in the shadows?']);
        Product::factory()->create(['title' => 'Ghostly Encounters', 'description' => 'True stories of paranormal activity.']);
        Product::factory()->create(['title' => 'Terror on Elm Street', 'description' => 'A neighborhood haunted by fear.']);
        Product::factory()->create(['title' => 'Math Made Easy', 'description' => 'Learn math with simple techniques.']);
        Product::factory()->create(['title' => 'The Science of Learning', 'description' => 'Discover how the brain learns.']);
        Product::factory()->create(['title' => 'History Unveiled', 'description' => 'Understand the past in new ways.']);
        Product::factory()->create(['title' => 'Mastering Physics', 'description' => 'A comprehensive guide to physics.']);
        Product::factory()->create(['title' => 'Programming Basics', 'description' => 'Learn to code with Python.']);

        // Send a search request
        $response = $this->get('/search?q=Haunted');

        // Assert the response
        $response->assertStatus(200);
        $response->assertJsonFragment(['html' => 'The Haunted Manor']);
        $response->assertJsonMissing(['html' => 'Math Made Easy']);
    }

    /** @test */
    public function it_returns_all_products_when_query_is_empty()
    {
        // Create some products
        Product::factory()->create(['title' => 'The Haunted Manor', 'description' => 'A chilling story of a haunted house.']);
        Product::factory()->create(['title' => 'Nightmares Unleashed', 'description' => 'Terrifying tales of the unknown.']);
        Product::factory()->create(['title' => 'Whispers in the Dark', 'description' => 'What hides in the shadows?']);
        Product::factory()->create(['title' => 'Ghostly Encounters', 'description' => 'True stories of paranormal activity.']);
        Product::factory()->create(['title' => 'Terror on Elm Street', 'description' => 'A neighborhood haunted by fear.']);
        Product::factory()->create(['title' => 'Math Made Easy', 'description' => 'Learn math with simple techniques.']);
        Product::factory()->create(['title' => 'The Science of Learning', 'description' => 'Discover how the brain learns.']);
        Product::factory()->create(['title' => 'History Unveiled', 'description' => 'Understand the past in new ways.']);
        Product::factory()->create(['title' => 'Mastering Physics', 'description' => 'A comprehensive guide to physics.']);
        Product::factory()->create(['title' => 'Programming Basics', 'description' => 'Learn to code with Python.']);

        // Send a search request with an empty query
        $response = $this->get('/search?q=');

        // Assert the response
        $response->assertStatus(200);
        $response->assertJsonFragment(['html' => 'The Haunted Manor']);
        $response->assertJsonFragment(['html' => 'Nightmares Unleashed']);
        $response->assertJsonFragment(['html' => 'Math Made Easy']);
    }
}
