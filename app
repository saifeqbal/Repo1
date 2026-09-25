package com.example.ludoapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlin.random.Random

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LudoGameScreen()
        }
    }
}

val players = listOf("RED", "GREEN", "YELLOW", "BLUE")

@Composable
fun LudoGameScreen() {
    var diceValue by remember { mutableStateOf(1) }
    var turnIndex by remember { mutableStateOf(0) }
    var positions by remember {
        mutableStateOf(mutableMapOf("RED" to 0, "GREEN" to 0, "YELLOW" to 0, "BLUE" to 0))
    }

    fun rollDice() {
        val rolled = Random.nextInt(1, 7)
        diceValue = rolled
        val currentPlayer = players[turnIndex]
        val currentPos = positions[currentPlayer] ?: 0
        positions[currentPlayer] = (currentPos + rolled) % 57
        turnIndex = (turnIndex + 1) % players.size
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFF1E3A8A)) // Blue Background
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Ludo Game",
            fontSize = 28.sp,
            fontWeight = FontWeight.Bold,
            color = Color.White,
            modifier = Modifier.padding(bottom = 20.dp)
        )

        // Board Container
        Card(
            shape = RoundedCornerShape(12.dp),
            colors = CardDefaults.cardColors(containerColor = Color.White),
            modifier = Modifier
                .size(320.dp)
                .padding(8.dp)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(8.dp),
                verticalArrangement = Arrangement.SpaceBetween
            ) {
                // Top Row
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    PlayerHomeBox("RED", Color(0xFFFF5733))
                    Text("Step: ${positions["RED"]}", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                    PlayerHomeBox("GREEN", Color(0xFF2ECC71))
                }

                // Center Home
                Box(
                    modifier = Modifier
                        .size(80.dp)
                        .align(Alignment.CenterHorizontally)
                        .background(Color(0xFFE2E8F0), RoundedCornerShape(8.dp)),
                    contentAlignment = Alignment.Center
                ) {
                    Text("HOME", fontWeight = FontWeight.Bold, color = Color.DarkGray)
                }

                // Bottom Row
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    PlayerHomeBox("BLUE", Color(0xFF3498DB))
                    Text("Step: ${positions["BLUE"]}", fontSize = 12.sp, fontWeight = FontWeight.Bold)
                    PlayerHomeBox("YELLOW", Color(0xFFF1C40F))
                }
            }
        }

        Spacer(modifier = Modifier.height(30.dp))

        // Controls
        Text(
            text = "Current Turn: ${players[turnIndex]}",
            fontSize = 18.sp,
            fontWeight = FontWeight.SemiBold,
            color = Color.White,
            modifier = Modifier.padding(bottom = 12.dp)
        )

        Button(
            onClick = { rollDice() },
            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF00D2FF)),
            shape = RoundedCornerShape(25.dp)
        ) {
            Text(
                text = "Roll Dice: $diceValue",
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1E3A8A)
            )
        }
    }
}

@Composable
fun PlayerHomeBox(name: String, color: Color) {
    Box(
        modifier = Modifier
            .size(90.dp)
            .background(color, RoundedCornerShape(8.dp)),
        contentAlignment = Alignment.Center
    ) {
        Text(text = name, color = Color.White, fontWeight = FontWeight.Bold)
    }
}
