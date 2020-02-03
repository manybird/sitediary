package net.powersl.sitediary;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;


public class StartCmPlayerServiceAtBootReceiver extends BroadcastReceiver {

    private static final String TAG = StartCmPlayerServiceAtBootReceiver.class.getSimpleName();

    @Override
    public void onReceive(Context context, Intent intent) {
        Log.i(TAG, "BOOT detected");
        if (Intent.ACTION_BOOT_COMPLETED.equals(intent.getAction())) {
            //Intent serviceIntent = new Intent(context, MainActivity.class);
            //context.startService(serviceIntent);

            Intent mIntent = new Intent(context, MainActivity.class);
            mIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(mIntent);
        }
    }
}