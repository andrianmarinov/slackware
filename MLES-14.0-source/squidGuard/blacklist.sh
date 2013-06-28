#!/bin/bash

# Université de Toulouse
HOST=ftp.ut-capitole.fr

# L'exécution du script est réservée à root
if [ `id -u` != 0 ]; then
  echo
  echo ":: Désolé, vous devez être root pour exécuter ce script."
  echo
  exit
fi

# Vérifier si l'hôte distant est joignable
ping -c 1 $HOST > /dev/null 2>&1 ||
  {
    echo
    echo ":: L'hôte distant n'est pas joignable."
    echo
    exit
  }

# Arrêter Squid
/etc/rc.d/rc.squid stop

# Récupérer les listes
cd /var/lib/squidguard
rsync -rv rsync://$HOST/blacklist .

# Ajout manuel de sites
#
# Sites qui dérangent par ailleurs
URLS="site-a-bloquer.com \
      autresite-a-bloquer.com"
rm -rf dest/pasglop && mkdir dest/pasglop
for URL in $URLS; do
        echo "$URL" >> dest/pasglop/domains
        echo "$URL" >> dest/pasglop/urls
done

# Sites qu'il ne faut pas bloquer
URLS="site-a-debloquer.com \
      autresite-a-debloquer.com"
rm -rf dest/glopglop && mkdir dest/glopglop
for URL in $URLS; do
        echo "$URL" >> dest/glopglop/domains
        echo "$URL" >> dest/glopglop/urls
done

# Définir les permissions
chown -R nobody:nobody dest

# Construire la base de données
echo ":: Construction de la base de données des sites..."
squidGuard -C all

# Rectifier les permissions
chown -R nobody:nobody /var/lib/squidguard
chown -R nobody:nobody /var/log/squidguard

# Redémarrer Squid
/etc/rc.d/rc.squid start

