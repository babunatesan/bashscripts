#copy kubernetes pods files to local volume.
#!/usr/bin/bash
filename="$1"
while read -r line; do
    name="$line"
    kubectl cp $2:/export/$name ~/Babu/minio-backup/$name
    echo "copied file $name to ~/Babu/minio-backup"
done < "$filename"
