<div class="container mx-auto p-6 bg-base-200 rounded-lg shadow-md">
    <h1 class="text-2xl font-semibold text-center mb-6">Users</h1>
    <div class="overflow-x-auto">
        <table class="table w-full">
            <thead>
                <tr>
                    <th class="text-center text-lg">ID</th>
                    <th class="text-center text-lg">Username</th>
                    <th class="text-center text-lg">Email</th>
                    <th class="text-center text-lg">Full Name</th>
                    <th class="text-center text-lg">Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach($users as $user)
                <tr>
                    <td class="text-center text-lg">{{ $user->id }}</td>
                    <td class="text-center text-lg">{{ $user->username }}</td>
                    <td class="text-center text-lg">{{ $user->email }}</td>
                    <td class="text-center text-lg">{{ $user->fullname }}</td>
                    <td class="text-center text-lg">
                        <button class="btn btn-primary ban-user" data-user-id="{{ $user->id }}">Ban</button>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</div>


<!-- Ban Confirmation Modal -->
<div id="ban-confirmation-modal" class="fixed inset-0 bg-gray-100 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-xl font-semibold mb-4">Confirm Ban</h2>
        <p id="ban-confirmation-message" class="mb-4"></p>
        <div class="flex justify-center">
            <button id="cancel-ban" class="btn btn-secondary mr-2">Cancel</button>
            <button id="confirm-ban" class="btn btn-danger">Confirm</button>
        </div>
    </div>
</div>


