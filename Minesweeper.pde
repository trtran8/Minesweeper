

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_COLS = 20;
public final static int NUM_ROWS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>() ; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int a=0;a<NUM_ROWS;a++){
        for(int b=0;b<NUM_COLS;b++){
            buttons[a][b]= new MSButton(a,b);
        }
    }
    setBombs();
}
public void setBombs()
{
    //your code
    int r=(int)(Math.random()*NUM_ROWS);
    int c=(int)(Math.random()*NUM_COLS);
    if(bombs.contains(buttons[r][c])==false){
        bombs.add(buttons[r][c]);
        System.out.println(r+","+c);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton==RIGHT){
            marked=true;
        }
        else if(bombs.contains(this)){
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0){
            setLabel(""+countBombs(r,c));
        }
        else{
            for(int a=r-1;a<r+1;a++){
                for(int b=c-1;b<c+1;b++){
                    if(isValid(a,b)){
                        buttons[a][b].mousePressed();
                    }
                }
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<NUM_ROWS&&r>=0&&c>=0&&c<NUM_COLS){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        //left up
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])){
                        numBombs++;
        }
        //left
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1])){
                        numBombs++;
        }
        //left down
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])){
                        numBombs++;
        }
        //down
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col])){
                        numBombs++;
        }
        //right down
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])){
                        numBombs++;
        }
        //right
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1])){
                        numBombs++;
        }
        //right up
        if(isValid(row-1,col+1)&& bombs.contains(buttons[row-1][col+1])){
                        numBombs++;
        }
        //up
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col])){
                        numBombs++;
        }
        return numBombs;
    }
}



