source ./env.sh

echo "Listing model directories in: $MODELS_DIR"

MODEL_DIRS=$(find "$MODELS_DIR" -mindepth 1 -maxdepth 1 -type d)

for dir in $MODEL_DIRS; do
  echo " - $(basename "$dir")"
done

echo

echo "Listing files inside each model directory:"

find "$MODELS_DIR" -mindepth 2 -type f | while read -r file; do
  # Derive model dir name relative to MODELS_DIR
  rel="${file#"$MODELS_DIR/"}"
  model="${rel%%/*}"
  echo "[$model] ${rel#*/}"
done