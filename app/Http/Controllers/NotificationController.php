<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\AuthenticatedUser;
use App\Models\Notification;
use Illuminate\Support\Facades\Log;

class NotificationController extends Controller
{
    public function getNotification()
    {
        $user = AuthenticatedUser::find(auth()->id());
        $notification = $user->notifications()->where('is_read', false)->latest()->first();
        return response()->json($notification ?? []);
    }

    public function markAsRead($id) {
        $notification = Notification::findOrFail($id);
        $notification->update(['is_read' => true]);
        return response()->json(['success' => true]);
    }
}
