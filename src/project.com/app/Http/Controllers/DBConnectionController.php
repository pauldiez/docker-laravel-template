<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\User;

class DBConnectionController extends Controller
{
    public function run()
    {
        $this->testDBConnection();
    }

    private function testDBConnection()
    {
        echo "Initializing queries";
        echo "</br></br>";

        $user = new User;
        $user->name = "Jimmy Butler";
        $user->email = "jimmy.butler@gmail.com";
        $user->password = 12345678;
        $user->save();

        $user = User::where('name', "Jimmy Butler")->first();
        $user->name = 'Colt Mayo';
        $user->save();

        if ($user->wasChanged()) {

            $users = User::all();
            foreach ($users as $user) {
                echo $user->name;
                echo "</br>";
            }

            $deletedRows = $user->delete();
            if (!$deletedRows) {
                echo "Error deleting record";
                echo "</br></br>";
            }

            echo "--------------";
            echo "</br>";
            echo "DB queries are working";
            echo "</br></br></br>";


        } else {
            echo "Something went wrong while updating db records";
        }

    }
}
