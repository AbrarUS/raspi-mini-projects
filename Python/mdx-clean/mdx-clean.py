import re
import sys
import emoji

def find_emojis(text):
    return list({ch for ch in text if emoji.is_emoji(ch)})

def markdown_to_plaintext(md_input: str, keep_emojis: bool) -> str:
    # Remove bold and italic markers
    text = re.sub(r'\*\*(.*?)\*\*', r'\1', md_input)
    text = re.sub(r'\*(.*?)\*', r'\1', text)

    # Remove headers
    text = re.sub(r'^#+\s*', '', text, flags=re.MULTILINE)

    # Replace list markers with bullet
    text = re.sub(r'^\s*[\*\-]\s+', '•\t', text, flags=re.MULTILINE)

    # Remove markdown-style links: [text](url) → text
    text = re.sub(r'\[(.*?)\]\(.*?\)', r'\1', text)

    # Remove emojis if not keeping them
    if not keep_emojis:
        for ch in find_emojis(text):
            text = text.replace(ch, '')

    # Clean extra blank lines
    lines = text.strip().splitlines()
    cleaned_lines = [line.rstrip() for line in lines if line.strip()]

    return '\n'.join(cleaned_lines)

if __name__ == "__main__":
    print("Paste your Markdown content below. Press Ctrl+D (Linux/macOS) or Ctrl+Z then Enter (Windows):\n")
    try:
        md_input = sys.stdin.read()
    except KeyboardInterrupt:
        print("\nInput cancelled.")
        sys.exit(1)

    emojis_found = find_emojis(md_input)
    keep_emojis = False

    if emojis_found:
        print(f"\n{len(emojis_found)} emoji(s) found in your content.")
        choice = input("Do you want to keep them? (y/n): ").strip().lower()
        keep_emojis = (choice == 'y')

    plain_text = markdown_to_plaintext(md_input, keep_emojis)

    with open("output.txt", "w", encoding="utf-8") as f:
        f.write(plain_text)

    print("\n✅ Cleaned content saved to: output.txt")
