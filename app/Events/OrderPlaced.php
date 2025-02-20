<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;


class OrderPlaced implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $message, $userId;

    public function __construct($userId) {
        $this->message = "Payment has been approved and the order was placed!";
        $this->userId = $userId;
    }

    public function broadcastOn() {
        return new Channel('orders');
    }

    public function broadcastAs() {
        return "notification-orderplaced";
    }
}
