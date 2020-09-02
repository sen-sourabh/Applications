import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.Scanner;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Sourabh
 */
public class TicTacToe {
    static ArrayList<Integer> playerPositions = new ArrayList<Integer>();
    static ArrayList<Integer> cpuPositions = new ArrayList<Integer>();
    public static void main(String[] args) {
        char[][] gameboard = {{' ', '|', ' ', '|', ' '},
                              {'-', '+', '-', '+', '-'},
                              {' ', '|', ' ', '|', ' '},
                              {'-', '+', '-', '+', '-'},
                              {' ', '|', ' ', '|', ' '}};
        printGameBoard(gameboard);
        while(true) {
            //PLAYER Plays here
            Scanner sc = new Scanner(System.in);
            System.out.println("Enter your placement(1-9) : ");
            int playerPos = sc.nextInt();
            while(playerPositions.contains(playerPos) || cpuPositions.contains(playerPos)) {
                System.out.println("Position taken, enter correct position");
                playerPos = sc.nextInt();
            }
            placePiece(gameboard, playerPos, "player");
            
            //Check Winner
            String winner = checkWinner();
            if(winner.length() > 0) {
                System.out.println(winner);
                printGameBoard(gameboard);
                break; //EXIT FROM GAME
            }
            
            //CPU Plays here
            Random rand = new Random();
            int cpuPos = rand.nextInt(9) + 1;
            while(playerPositions.contains(cpuPos) || cpuPositions.contains(cpuPos)) {
//                System.out.println("Position taken, enter correct position");
                cpuPos = rand.nextInt(9) + 1;
            }
            placePiece(gameboard, cpuPos, "cpu");
            
            //Print gameboard at every turn
            printGameBoard(gameboard);
            //Check Winner
            winner = checkWinner();
            if(winner.length() > 0) {
                System.out.println(winner);
                printGameBoard(gameboard);
                break; //EXIT FROM GAME
            }
        }
    }
    //Print GameBoard Function
    public static void printGameBoard(char[][] gameBoard) {
        for(char[] row : gameBoard) {
            for(char c : row) {
                System.out.print(c);
            }
            System.out.println();
        }
    }
    //Place TicTac in GameBoard Function
    public static void placePiece(char[][] gameBoard, int pos, String User) {
        char symbol = ' ';
        if(User.equals("player")) {
            symbol = 'X';
            playerPositions.add(pos);
        }else if(User.equals("cpu")){
            symbol = 'O';
            cpuPositions.add(pos);
        }
        switch(pos) {
            case 1:
                gameBoard[0][0] = symbol;
                break;
                
            case 2:
                gameBoard[0][2] = symbol;
                break;
            
            case 3:
                gameBoard[0][4] = symbol;
                break;
                
            case 4:
                gameBoard[2][0] = symbol;
                break;
            
            case 5:
                gameBoard[2][2] = symbol;
                break;
            
            case 6:
                gameBoard[2][4] = symbol;
                break;
            
            case 7:
                gameBoard[4][0] = symbol;
                break;
            
            case 8:
                gameBoard[4][2] = symbol;
                break;
            
            case 9:
                gameBoard[4][4] = symbol;
                break;
        }
    }
    //Check Winner Function
    public static String checkWinner() {
        List topRow = Arrays.asList(1,2,3);
        List midRow = Arrays.asList(4,5,6);
        List botRow = Arrays.asList(7,8,9);
        List leftCol = Arrays.asList(1,4,7);
        List midCol = Arrays.asList(2,5,8);
        List rightCol = Arrays.asList(3,6,9);
        List cross1 = Arrays.asList(1,5,9);
        List cross2 = Arrays.asList(7,5,3);
        
        List<List> win = new ArrayList<List>();
        win.add(topRow);
        win.add(midRow);
        win.add(botRow);
        win.add(leftCol);
        win.add(midCol);
        win.add(rightCol);
        win.add(cross1);
        win.add(cross2);
        
        for(List l : win) {
            if(playerPositions.containsAll(l)) {
                return "Congratulations you WON! :)";
            }else if(cpuPositions.containsAll(l)) {
                return "CPU WINS! Sorry :(";
            }else if(playerPositions.size() + cpuPositions.size() == 9) {
                return "CAT!";
            }
        }
        return "";
    }
}