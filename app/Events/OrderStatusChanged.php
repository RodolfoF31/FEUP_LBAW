<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class OrderStatusChanged implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $userId, $message;

    public function __construct($userId, $message) {
        $this->userId = $userId;
        $this->message = $message;
    }

    public function broadcastOn()
    {
        return new Channel('orders');
    }

    public function broadcastAs() {
        return 'notification-orderstatuschanged';
    }
}
