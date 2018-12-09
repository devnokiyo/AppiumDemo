package com.example.devnokiyo.appiumdemo

import android.app.Dialog
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.DialogFragment
import android.support.v7.app.AlertDialog
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btnLogin.setOnClickListener {
            if(txtId.text.toString() == "devnokiyo" && txtPassword.text.toString() == "abcd1234") {
                // サンプルアプリなので戻るボタンで再びログイン画面が表示されることは許容とする。
                startActivity(Intent(this, WelcomeActivity::class.java))
            } else {
                DialogFragment()
                com.example.devnokiyo.appiumdemo.Dialog().show(supportFragmentManager, null)
            }
        }
    }
}
class Dialog : DialogFragment() {
    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return AlertDialog.Builder(activity!!)
            .setTitle("認証エラー")
            .setMessage("IDまたはパスワードが違います。")
            .setNegativeButton("OK"
            ) { _, _ ->
                dismiss()
            }.create()
    }
}