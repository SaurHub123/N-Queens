// import 'package:flutter/material.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';

// void main() {
//   runApp(const NQueensApp());
// }

// class NQueensApp extends StatelessWidget {
//   const NQueensApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'N-Queens Puzzle',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const GameSelectionScreen(),
//     );
//   }
// }

// class GameSelectionScreen extends StatelessWidget {
//   const GameSelectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Board Size'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.indigo.shade100,
//               Colors.indigo.shade50,
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'N-Queens Puzzle',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
//                   child: Text(
//                     'Place N queens on an N×N chessboard so that no two queens threaten each other',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.indigo,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Wrap(
//                   alignment: WrapAlignment.center,
//                   spacing: 16,
//                   runSpacing: 16,
//                   children: [
//                     for (int size = 4; size <= 9; size++)
//                       _BoardSizeButton(
//                         size: size,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => NQueensGame(size: size),
//                             ),
//                           );
//                         },
//                       ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 _HowToPlayButton(),

//                 const Text('Design and Developed By Saurabh.'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BoardSizeButton extends StatelessWidget {
//   final int size;
//   final VoidCallback onPressed;

//   const _BoardSizeButton({
//     required this.size,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: 120,
//         height: 120,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.indigo.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$size × $size',
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '${_getSolutionCount(size)} solutions',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.indigo.shade400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _getSolutionCount(int size) {
//     // Known number of solutions for standard N-Queens
//     final solutions = [0, 1, 0, 0, 2, 10, 4, 40, 92, 352];
//     return size < solutions.length ? solutions[size].toString() : '?';
//   }
// }

// class _HowToPlayButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('How to Play'),
//             content: const SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'N-Queens Puzzle Rules:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     '1. Place queens on the board so that no two queens threaten each other.',
//                   ),
//                   Text(
//                     '2. Queens can move any number of squares vertically, horizontally, or diagonally.',
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Game Features:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('• Tap a square to place/remove a queen'),
//                   Text('• Undo your last move if needed'),
//                   Text('• Clear the board to start over'),
//                   Text('• Find all unique solutions for each board size'),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Got it!'),
//               ),
//             ],
//           ),
//         );
//       },
//       child: const Text(
//         'How to Play',
//         style: TextStyle(color: Colors.indigo),
//       ),
//     );
//   }
// }

// class NQueensGame extends StatefulWidget {
//   final int size;

//   const NQueensGame({super.key, required this.size});

//   @override
//   State<NQueensGame> createState() => _NQueensGameState();
// }

// class _NQueensGameState extends State<NQueensGame> {
//   late List<List<int?>> board;
//   List<Color> queenColors = [];
//   final Stack<Map<String, dynamic>> moveHistory = Stack();
//   final StopWatchTimer stopWatchTimer = StopWatchTimer();
//   final Set<String> foundSolutions = {};
//   bool isSolved = false;
//   bool showConflicts = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeGame();
//     stopWatchTimer.onStartTimer();
//   }

//   @override
//   void dispose() {
//     stopWatchTimer.dispose();
//     super.dispose();
//   }

//   void _initializeGame() {
//     board = List.generate(widget.size, (_) => List.filled(widget.size, null));
    
//     // Generate distinct colors for each queen
//     queenColors = List.generate(widget.size, (index) {
//       final hue = (index * 360 / widget.size) % 360;
//       return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
//     });
//   }

//   bool _isSafe(int row, int col) {
//     // Check column
//     for (int i = 0; i < widget.size; i++) {
//       if (board[i][col] != null && i != row) return false;
//     }

//     // Check row
//     for (int j = 0; j < widget.size; j++) {
//       if (board[row][j] != null && j != col) return false;
//     }

//     // Check diagonals
//     for (int i = 1; i < widget.size; i++) {
//       if (row - i >= 0 && col - i >= 0 && board[row - i][col - i] != null) return false;
//       if (row - i >= 0 && col + i < widget.size && board[row - i][col + i] != null) return false;
//       if (row + i < widget.size && col - i >= 0 && board[row + i][col - i] != null) return false;
//       if (row + i < widget.size && col + i < widget.size && board[row + i][col + i] != null) return false;
//     }

//     return true;
//   }

//   // bool _isSafe(int row, int col) {
//   //   // Check column
//   //   for (int i = 0; i < widget.size; i++) {
//   //     if (board[i][col] != null && i != row) return false;
//   //   }

//   //   // Check row
//   //   for (int j = 0; j < widget.size; j++) {
//   //     if (board[row][j] != null && j != col) return false;
//   //   }

//   //   // Optimized diagonal check - only immediate adjacent squares
//   //   // Top-left
//   //   if (row > 0 && col > 0 && board[row-1][col-1] != null) return false;
//   //   // Top-right
//   //   if (row > 0 && col < widget.size-1 && board[row-1][col+1] != null) return false;
//   //   // Bottom-left
//   //   if (row < widget.size-1 && col > 0 && board[row+1][col-1] != null) return false;
//   //   // Bottom-right
//   //   if (row < widget.size-1 && col < widget.size-1 && board[row+1][col+1] != null) return false;

//   //   return true;
//   // }

//   bool _hasConflict(int row, int col) {
//     if (board[row][col] == null) return false;
    
//     // Check column
//     for (int i = 0; i < widget.size; i++) {
//       if (board[i][col] != null && i != row) return true;
//     }

//     // Check row
//     for (int j = 0; j < widget.size; j++) {
//       if (board[row][j] != null && j != col) return true;
//     }

//     // Check diagonals
//     for (int i = 1; i < widget.size; i++) {
//       if (row - i >= 0 && col - i >= 0 && board[row - i][col - i] != null) return true;
//       if (row - i >= 0 && col + i < widget.size && board[row - i][col + i] != null) return true;
//       if (row + i < widget.size && col - i >= 0 && board[row + i][col - i] != null) return true;
//       if (row + i < widget.size && col + i < widget.size && board[row + i][col + i] != null) return true;
//     }

//     return false;
//   }

//   void _placeQueen(int row, int col) {
//     if (isSolved) return;

//     // Save current state for undo
//     moveHistory.push({
//       'row': row,
//       'col': col,
//       'previousValue': board[row][col],
//     });

//     setState(() {
//       board[row][col] = board[row][col] == null ? row : null;
//     });

//     if (board[row][col] != null && !_isSafe(row, col)) {
//       _showViolationMessage();
//       setState(() {
//         showConflicts = true;
//       });
//     } else {
//       setState(() {
//         showConflicts = false;
//       });
//       _checkSolution();
//     }
//   }

//   void _checkSolution() {
//     int queenCount = 0;
//     bool allSafe = true;

//     for (int i = 0; i < widget.size; i++) {
//       for (int j = 0; j < widget.size; j++) {
//         if (board[i][j] != null) {
//           queenCount++;
//           if (!_isSafe(i, j)) {
//             allSafe = false;
//             break;
//           }
//         }
//       }
//       if (!allSafe) break;
//     }

//     if (allSafe && queenCount == widget.size) {
//       final solution = _getBoardString();
//       if (foundSolutions.contains(solution)) {
//         _showExistingSolutionMessage();
//         _clearBoard();
//       } else {
//         foundSolutions.add(solution);
//         setState(() {
//           isSolved = true;
//           showConflicts = false;
//         });
//         stopWatchTimer.onStopTimer();
//         _showSuccessMessage();
//       }
//     }
//   }

//   String _getBoardString() {
//     String result = '';
//     for (int i = 0; i < widget.size; i++) {
//       for (int j = 0; j < widget.size; j++) {
//         result += board[i][j] != null ? 'Q' : '.';
//       }
//     }
//     return result;
//   }

//   void _showViolationMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Queen placement violates game rules!'),
//         backgroundColor: Colors.red.shade400,
//         duration: const Duration(seconds: 1),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   void _showSuccessMessage() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => AlertDialog(
//         title: const Text('Solution Found!'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Time: ${StopWatchTimer.getDisplayTime(stopWatchTimer.rawTime.value)}'),
//             Text('Solution #${foundSolutions.length}'),
//             const SizedBox(height: 16),
//             const Text('Would you like to find another solution?'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _clearBoard();
//             },
//             child: const Text('Find Another'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Continue'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showExistingSolutionMessage() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('This solution already exists! Try a different arrangement.'),
//         backgroundColor: Colors.orange.shade400,
//         duration: const Duration(seconds: 3),
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   void _undoLastMove() {
//     if (moveHistory.isNotEmpty) {
//       final lastMove = moveHistory.pop();
//       setState(() {
//         board[lastMove['row']][lastMove['col']] = lastMove['previousValue'];
//         isSolved = false;
//         showConflicts = false;
//       });
//     }
//   }

//   void _clearBoard() {
//     setState(() {
//       _initializeGame();
//       moveHistory.clear();
//       isSolved = false;
//       showConflicts = false;
//     });
//     stopWatchTimer.onResetTimer();
//     stopWatchTimer.onStartTimer();
//   }

//   void _resetGame() {
//     setState(() {
//       _initializeGame();
//       moveHistory.clear();
//       foundSolutions.clear();
//       isSolved = false;
//       showConflicts = false;
//     });
//     stopWatchTimer.onResetTimer();
//     stopWatchTimer.onStartTimer();
//   }

//   void _toggleConflictDisplay() {
//     setState(() {
//       showConflicts = !showConflicts;
//     });
//   }

//   void _showSolutionCountInfo() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Solution Information'),
//         content: Text(
//           'For a ${widget.size}×${widget.size} board, there are ${_getTotalSolutionCount()} distinct solutions.\n\n'
//           'You have found ${foundSolutions.length} so far!',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getTotalSolutionCount() {
//     final solutions = [0, 1, 0, 0, 2, 10, 4, 40, 92, 352];
//     return widget.size < solutions.length ? solutions[widget.size].toString() : 'many';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${widget.size}×${widget.size} N-Queens'),
//         centerTitle: true,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: _showSolutionCountInfo,
//             tooltip: 'Solution Info',
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _resetGame,
//             tooltip: 'Reset Game',
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.indigo.shade100,
//               Colors.indigo.shade50,
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _GameStats(
//                   stopWatchTimer: stopWatchTimer,
//                   solutionsFound: foundSolutions.length,
//                   totalSolutions: _getTotalSolutionCount(),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.indigo, width: 2),
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.indigo.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: widget.size,
//                     ),
//                     itemCount: widget.size * widget.size,
//                     itemBuilder: (context, index) {
//                       final row = index ~/ widget.size;
//                       final col = index % widget.size;
//                       final queenIndex = board[row][col];
//                       final hasConflict = showConflicts && _hasConflict(row, col);
                      
//                       return GestureDetector(
//                         onTap: () => _placeQueen(row, col),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: (row + col) % 2 == 0 
//                                 ? Colors.white 
//                                 : Colors.grey.shade100,
//                             border: Border.all(
//                               color: hasConflict 
//                                   ? Colors.red.shade400 
//                                   : Colors.grey.shade300,
//                               width: hasConflict ? 2 : 1,
//                             ),
//                           ),
//                           child: Center(
//                             child: queenIndex != null
//                                 ? Container(
//                                     width: 32,
//                                     height: 32,
//                                     decoration: BoxDecoration(
//                                       color: queenColors[queenIndex],
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 4,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Icon(
//                                       Icons.face,
//                                       size: 20,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 : null,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 _GameControls(
//                   canUndo: moveHistory.isNotEmpty,
//                   onUndo: _undoLastMove,
//                   onClear: _clearBoard,
//                   showConflicts: showConflicts,
//                   onToggleConflicts: _toggleConflictDisplay,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _GameStats extends StatelessWidget {
//   final StopWatchTimer stopWatchTimer;
//   final int solutionsFound;
//   final String totalSolutions;

//   const _GameStats({
//     required this.stopWatchTimer,
//     required this.solutionsFound,
//     required this.totalSolutions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.indigo.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               const Text(
//                 'Time',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.indigo,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               StreamBuilder<int>(
//                 stream: stopWatchTimer.rawTime,
//                 initialData: 0,
//                 builder: (context, snap) {
//                   final value = snap.data!;
//                   final displayTime = StopWatchTimer.getDisplayTime(value);
//                   return Text(
//                     displayTime,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               const Text(
//                 'Solutions',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.indigo,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '$solutionsFound/$totalSolutions',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigo,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _GameControls extends StatelessWidget {
//   final bool canUndo;
//   final VoidCallback onUndo;
//   final VoidCallback onClear;
//   final bool showConflicts;
//   final VoidCallback onToggleConflicts;

//   const _GameControls({
//     required this.canUndo,
//     required this.onUndo,
//     required this.onClear,
//     required this.showConflicts,
//     required this.onToggleConflicts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton.icon(
//           onPressed: canUndo ? onUndo : null,
//           icon: const Icon(Icons.undo, size: 20),
//           label: const Text('Undo'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.indigo.shade50,
//             foregroundColor: Colors.indigo,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         ElevatedButton.icon(
//           onPressed: onClear,
//           icon: const Icon(Icons.clear, size: 20),
//           label: const Text('Clear'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.indigo.shade50,
//             foregroundColor: Colors.indigo,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         ElevatedButton.icon(
//           onPressed: onToggleConflicts,
//           icon: Icon(
//             showConflicts ? Icons.visibility_off : Icons.visibility,
//             size: 20,
//           ),
//           label: Text(showConflicts ? 'Hide Conflicts' : 'Show Conflicts'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: showConflicts 
//                 ? Colors.red.shade50 
//                 : Colors.indigo.shade50,
//             foregroundColor: showConflicts 
//                 ? Colors.red 
//                 : Colors.indigo,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Stack<T> {
//   final List<T> _items = [];

//   void push(T item) => _items.add(item);
//   T pop() => _items.removeLast();
//   bool get isNotEmpty => _items.isNotEmpty;
//   void clear() => _items.clear();
// }



import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main() {
  runApp(const NQueensApp());
}

class NQueensApp extends StatelessWidget {
  const NQueensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'N-Queens Puzzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GameSelectionScreen(),
    );
  }
}

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Board Size'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade100,
              Colors.indigo.shade50,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'N-Queens Puzzle',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 28 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 16 : 32,
                      vertical: 16,
                    ),
                    child: Text(
                      'Place N queens on an N×N chessboard so that no two queens threaten each other',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final buttonSize = constraints.maxWidth / (isSmallScreen ? 3 : 4) - 20;
                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (int size = 4; size <= 9; size++)
                            _BoardSizeButton(
                              size: size,
                              buttonSize: buttonSize,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NQueensGame(size: size),
                                  ),
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  _HowToPlayButton(),
                  const SizedBox(height: 20),
                  const Text('Design and Developed By Saurabh.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BoardSizeButton extends StatelessWidget {
  final int size;
  final double buttonSize;
  final VoidCallback onPressed;

  const _BoardSizeButton({
    required this.size,
    required this.buttonSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$size × $size',
              style: TextStyle(
                fontSize: buttonSize * 0.2,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_getSolutionCount(size)} solutions',
              style: TextStyle(
                fontSize: buttonSize * 0.1,
                color: Colors.indigo.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSolutionCount(int size) {
    final solutions = [0, 1, 0, 0, 2, 10, 4, 40, 92, 352];
    return size < solutions.length ? solutions[size].toString() : '?';
  }
}

class _HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('How to Play'),
            content: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'N-Queens Puzzle Rules:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Place queens on the board so that no two queens threaten each other.',
                  ),
                  Text(
                    '2. Queens can move any number of squares vertically, horizontally, or diagonally.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Game Features:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• Tap a square to place/remove a queen'),
                  Text('• Undo your last move if needed'),
                  Text('• Clear the board to start over'),
                  Text('• Find all unique solutions for each board size'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it!'),
              ),
            ],
          ),
        );
      },
      child: const Text(
        'How to Play',
        style: TextStyle(color: Colors.indigo),
      ),
    );
  }
}

class NQueensGame extends StatefulWidget {
  final int size;

  const NQueensGame({super.key, required this.size});

  @override
  State<NQueensGame> createState() => _NQueensGameState();
}

class _NQueensGameState extends State<NQueensGame> {
  late List<List<int?>> board;
  List<Color> queenColors = [];
  final Stack<Map<String, dynamic>> moveHistory = Stack();
  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  final Set<String> foundSolutions = {};
  bool isSolved = false;
  bool showConflicts = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
    stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  void _initializeGame() {
    board = List.generate(widget.size, (_) => List.filled(widget.size, null));
    
    queenColors = List.generate(widget.size, (index) {
      final hue = (index * 360 / widget.size) % 360;
      return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
    });
  }

  bool _isSafe(int row, int col) {
    for (int i = 0; i < widget.size; i++) {
      if (board[i][col] != null && i != row) return false;
    }

    for (int j = 0; j < widget.size; j++) {
      if (board[row][j] != null && j != col) return false;
    }

    for (int i = 1; i < widget.size; i++) {
      if (row - i >= 0 && col - i >= 0 && board[row - i][col - i] != null) return false;
      if (row - i >= 0 && col + i < widget.size && board[row - i][col + i] != null) return false;
      if (row + i < widget.size && col - i >= 0 && board[row + i][col - i] != null) return false;
      if (row + i < widget.size && col + i < widget.size && board[row + i][col + i] != null) return false;
    }

    return true;
  }

  bool _hasConflict(int row, int col) {
    if (board[row][col] == null) return false;
    
    for (int i = 0; i < widget.size; i++) {
      if (board[i][col] != null && i != row) return true;
    }

    for (int j = 0; j < widget.size; j++) {
      if (board[row][j] != null && j != col) return true;
    }

    for (int i = 1; i < widget.size; i++) {
      if (row - i >= 0 && col - i >= 0 && board[row - i][col - i] != null) return true;
      if (row - i >= 0 && col + i < widget.size && board[row - i][col + i] != null) return true;
      if (row + i < widget.size && col - i >= 0 && board[row + i][col - i] != null) return true;
      if (row + i < widget.size && col + i < widget.size && board[row + i][col + i] != null) return true;
    }

    return false;
  }

  void _placeQueen(int row, int col) {
    if (isSolved) return;

    moveHistory.push({
      'row': row,
      'col': col,
      'previousValue': board[row][col],
    });

    setState(() {
      board[row][col] = board[row][col] == null ? row : null;
    });

    if (board[row][col] != null && !_isSafe(row, col)) {
      _showViolationMessage();
      setState(() {
        showConflicts = true;
      });
    } else {
      setState(() {
        showConflicts = false;
      });
      _checkSolution();
    }
  }

  void _checkSolution() {
    int queenCount = 0;
    bool allSafe = true;

    for (int i = 0; i < widget.size; i++) {
      for (int j = 0; j < widget.size; j++) {
        if (board[i][j] != null) {
          queenCount++;
          if (!_isSafe(i, j)) {
            allSafe = false;
            break;
          }
        }
      }
      if (!allSafe) break;
    }

    if (allSafe && queenCount == widget.size) {
      final solution = _getBoardString();
      if (foundSolutions.contains(solution)) {
        _showExistingSolutionMessage();
        _clearBoard();
      } else {
        foundSolutions.add(solution);
        setState(() {
          isSolved = true;
          showConflicts = false;
        });
        stopWatchTimer.onStopTimer();
        _showSuccessMessage();
      }
    }
  }

  String _getBoardString() {
    String result = '';
    for (int i = 0; i < widget.size; i++) {
      for (int j = 0; j < widget.size; j++) {
        result += board[i][j] != null ? 'Q' : '.';
      }
    }
    return result;
  }

  void _showViolationMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Queen placement violates game rules!'),
        backgroundColor: Colors.red.shade400,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSuccessMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Solution Found!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Time: ${StopWatchTimer.getDisplayTime(stopWatchTimer.rawTime.value)}'),
            Text('Solution #${foundSolutions.length}'),
            const SizedBox(height: 16),
            const Text('Would you like to find another solution?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearBoard();
            },
            child: const Text('Find Another'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showExistingSolutionMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This solution already exists! Try a different arrangement.'),
        backgroundColor: Colors.orange.shade400,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _undoLastMove() {
    if (moveHistory.isNotEmpty) {
      final lastMove = moveHistory.pop();
      setState(() {
        board[lastMove['row']][lastMove['col']] = lastMove['previousValue'];
        isSolved = false;
        showConflicts = false;
      });
    }
  }

  void _clearBoard() {
    setState(() {
      _initializeGame();
      moveHistory.clear();
      isSolved = false;
      showConflicts = false;
    });
    stopWatchTimer.onResetTimer();
    stopWatchTimer.onStartTimer();
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
      moveHistory.clear();
      foundSolutions.clear();
      isSolved = false;
      showConflicts = false;
    });
    stopWatchTimer.onResetTimer();
    stopWatchTimer.onStartTimer();
  }

  void _toggleConflictDisplay() {
    setState(() {
      showConflicts = !showConflicts;
    });
  }

  void _showSolutionCountInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solution Information'),
        content: Text(
          'For a ${widget.size}×${widget.size} board, there are ${_getTotalSolutionCount()} distinct solutions.\n\n'
          'You have found ${foundSolutions.length} so far!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _getTotalSolutionCount() {
    final solutions = [0, 1, 0, 0, 2, 10, 4, 40, 92, 352];
    return widget.size < solutions.length ? solutions[widget.size].toString() : 'many';
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final boardSize = isSmallScreen 
        ? screenWidth * 0.9
        : (screenHeight > screenWidth ? screenWidth * 0.8 : screenHeight * 0.7);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.size}×${widget.size} N-Queens'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showSolutionCountInfo,
            tooltip: 'Solution Info',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetGame,
            tooltip: 'Reset Game',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo.shade100,
              Colors.indigo.shade50,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GameStats(
                  stopWatchTimer: stopWatchTimer,
                  solutionsFound: foundSolutions.length,
                  totalSolutions: _getTotalSolutionCount(),
                ),
                const SizedBox(height: 16),
                Container(
                  width: boardSize,
                  height: boardSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.size,
                    ),
                    itemCount: widget.size * widget.size,
                    itemBuilder: (context, index) {
                      final row = index ~/ widget.size;
                      final col = index % widget.size;
                      final queenIndex = board[row][col];
                      final hasConflict = showConflicts && _hasConflict(row, col);
                      
                      return GestureDetector(
                        onTap: () => _placeQueen(row, col),
                        child: Container(
                          decoration: BoxDecoration(
                            color: (row + col) % 2 == 0 
                                ? Colors.white 
                                : Colors.grey.shade100,
                            border: Border.all(
                              color: hasConflict 
                                  ? Colors.red.shade400 
                                  : Colors.grey.shade300,
                              width: hasConflict ? 2 : 1,
                            ),
                          ),
                          child: Center(
                            child: queenIndex != null
                                ? Container(
                                    width: boardSize / widget.size * 0.6,
                                    height: boardSize / widget.size * 0.6,
                                    decoration: BoxDecoration(
                                      color: queenColors[queenIndex],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.face,
                                      size: boardSize / widget.size * 0.3,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                _GameControls(
                  canUndo: moveHistory.isNotEmpty,
                  onUndo: _undoLastMove,
                  onClear: _clearBoard,
                  showConflicts: showConflicts,
                  onToggleConflicts: _toggleConflictDisplay,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GameStats extends StatelessWidget {
  final StopWatchTimer stopWatchTimer;
  final int solutionsFound;
  final String totalSolutions;

  const _GameStats({
    required this.stopWatchTimer,
    required this.solutionsFound,
    required this.totalSolutions,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const Text(
                'Time',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 4),
              StreamBuilder<int>(
                stream: stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime = StopWatchTimer.getDisplayTime(value);
                  return Text(
                    displayTime,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                'Solutions',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$solutionsFound/$totalSolutions',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GameControls extends StatelessWidget {
  final bool canUndo;
  final VoidCallback onUndo;
  final VoidCallback onClear;
  final bool showConflicts;
  final VoidCallback onToggleConflicts;
  final bool isSmallScreen;

  const _GameControls({
    required this.canUndo,
    required this.onUndo,
    required this.onClear,
    required this.showConflicts,
    required this.onToggleConflicts,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    if (isSmallScreen) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildControlButton(
                icon: Icons.undo,
                label: 'Undo',
                onPressed: canUndo ? onUndo : null,
                isActive: canUndo,
              ),
              const SizedBox(width: 16),
              _buildControlButton(
                icon: Icons.clear,
                label: 'Clear',
                onPressed: onClear,
                isActive: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildControlButton(
            icon: showConflicts ? Icons.visibility_off : Icons.visibility,
            label: showConflicts ? 'Hide Conflicts' : 'Show Conflicts',
            onPressed: onToggleConflicts,
            isActive: true,
            isConflictButton: true,
            showConflicts: showConflicts,
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton(
            icon: Icons.undo,
            label: 'Undo',
            onPressed: canUndo ? onUndo : null,
            isActive: canUndo,
          ),
          const SizedBox(width: 16),
          _buildControlButton(
            icon: Icons.clear,
            label: 'Clear',
            onPressed: onClear,
            isActive: true,
          ),
          const SizedBox(width: 16),
          _buildControlButton(
            icon: showConflicts ? Icons.visibility_off : Icons.visibility,
            label: showConflicts ? 'Hide Conflicts' : 'Show Conflicts',
            onPressed: onToggleConflicts,
            isActive: true,
            isConflictButton: true,
            showConflicts: showConflicts,
          ),
        ],
      );
    }
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required bool isActive,
    bool isConflictButton = false,
    bool showConflicts = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isConflictButton
            ? (showConflicts ? Colors.red.shade50 : Colors.indigo.shade50)
            : Colors.indigo.shade50,
        foregroundColor: isConflictButton
            ? (showConflicts ? Colors.red : Colors.indigo)
            : Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 8 : 12,
        ),
      ),
    );
  }
}

class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);
  T pop() => _items.removeLast();
  bool get isNotEmpty => _items.isNotEmpty;
  void clear() => _items.clear();
}