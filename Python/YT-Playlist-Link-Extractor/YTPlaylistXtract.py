import yt_dlp
import csv
import datetime

playlist_url = input("Enter the playlist URL: ").strip()

# Extract the playlist ID from the URL
import urllib.parse as urlparse
query_params = urlparse.parse_qs(urlparse.urlparse(playlist_url).query)
playlist_id = query_params.get('list', [None])[0]

if not playlist_id:
    raise ValueError("Invalid playlist URL. Please provide a valid YouTube playlist URL.")

# Cleaned playlist URL
playlist_url = f"https://www.youtube.com/playlist?list={playlist_id}"
ydl_opts = {'quiet': True, 'extract_flat': True}


with yt_dlp.YoutubeDL(ydl_opts) as ydl:
    playlist_info = ydl.extract_info(playlist_url, download=False)
    title_url_list = [(entry['title'], entry['url']) for entry in playlist_info['entries']]

# Generate the output file name
playlist_name = playlist_info.get('title', 'playlist').replace(' ', '_')
current_date = datetime.datetime.now().strftime('%Y%m%d')
output_file_name = f'yt_playlist_{playlist_name}_{current_date}.csv'

with open(output_file_name, 'w', newline='') as file:
    csv_file = csv.writer(file)
    csv_file.writerow(['Title', 'URL'])
    csv_file.writerows(title_url_list)
