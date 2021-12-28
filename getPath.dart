function getNextMove(path, position, attempt) {
  let possibleMoves = [
    [1, 2],
    [1, 3],
    [1, 4],
    [2, 3],
    [2, 4],
    [3, 4],
    [2, 1],
    [3, 1],
    [4, 1],
    [3, 2],
    [4, 2],
    [4, 3]
  ];
  const verticalMoves = [
    [1, 3],
    [3, 1],
    [2, 4],
    [4, 2]
  ];
  const horizontalMoves = [
    [1, 2],
    [2, 1],
    [3, 4],
    [4, 3]
  ];
  const diagonalMoves = [
    [1, 4],
    [4, 1],
    [2, 3],
    [3, 2]
  ];

  let moveTypesMade = {
    vertical: [],
    horizontal: [],
    diagonal: []
  };

  //Populate move types made
  path.forEach((item) => {
    if (isContained(verticalMoves, item)) {
      moveTypesMade.vertical.push(item);
    }
    if (isContained(horizontalMoves, item)) {
      moveTypesMade.horizontal.push(item);
    }
    if (isContained(diagonalMoves, item)) {
      moveTypesMade.diagonal.push(item);
    }
  });
  //-------------------------

  //Filters
  possibleMoves = possibleMoves.filter((item) => {
    return !isContained(path, item);
  });

  //by move type
  if (moveTypesMade.vertical.length >= 2) {
    possibleMoves = possibleMoves.filter((item) => {
      return !isContained(verticalMoves, item);
    });
  }
  if (moveTypesMade.horizontal.length >= 2) {
    possibleMoves = possibleMoves.filter((item) => {
      return !isContained(horizontalMoves, item);
    });
  }
  if (moveTypesMade.diagonal.length >= 2) {
    possibleMoves = possibleMoves.filter((item) => {
      return !isContained(diagonalMoves, item);
    });
  }

  //by position
  possibleMoves = possibleMoves.filter((item) => {
    return item[0] === position;
  });
  //------------------end of filters

  if (possibleMoves.length > attempt) {
    return possibleMoves[attempt];
  } else return [];
}

function isContained(list, move) {
  let result = false;
  list.forEach((item) => {
    if (
      (item[0] === move[0] && item[1] === move[1]) ||
      (item[0] === move[1] && item[1] === move[0])
    ) {
      result = true;
      return;
    }
  });
  return result;
}

function getPath(path, attempt) {
  console.log("i", path, attempt);
  if (path.length >= 6) {
    return path;
  }
  if (path.length === 0) {
    path.push(getNextMove(path, 1, attempt));
  }
  const currentPosition = path[path.length - 1][1];
  const nextMove = getNextMove(path, currentPosition, attempt);

  if (nextMove.length > 0) {
    path.push(nextMove);
    getPath(path, attempt);
  } else if (attempt < 9) {
    attempt += 1;
    const newPath = path.slice(0, path.length - attempt);
    if (newPath.length > 1) {
      getPath(newPath, attempt);
    }
  }
  return ["Impossible"];
}

console.log("RESULTADO:", getPath([], 0));