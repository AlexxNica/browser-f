#! /bin/bash -vex

. pre-build.sh

if [ 0$B2G_DEBUG -ne 0 ]; then
    DEBUG_SUFFIX=-debug
fi

if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh
fi

aws s3 cp s3://b2g-nightly-credentials/balrog_credentials .
aws s3 cp s3://b2g-nightly-credentials/b2g-rsa $HOME/.ssh/

./mozharness/scripts/b2g_build.py \
  --config b2g/taskcluster-phone-nightly.py \
  --config balrog/staging.py \
  "$debug_flag" \
  --disable-mock \
  --variant=$VARIANT \
  --work-dir=$WORKSPACE/B2G \
  --gaia-languages-file locales/languages_all.json \
  --log-level=debug \
  --target=$TARGET \
  --b2g-config-dir=$TARGET \
  --checkout-revision=$GECKO_HEAD_REV \
  --base-repo=$GECKO_BASE_REPOSITORY \
  --repo=$GECKO_HEAD_REPOSITORY \
  --platform $TARGET \
  --complete-mar-url https://queue.taskcluster.net/v1/task/$TASK_ID/runs/0/artifacts/public/build/b2g-${TARGET%%-*}-gecko-update.mar \

# Don't cache backups
rm -rf $WORKSPACE/B2G/backup-*
rm -f balrog_credentials
rm -f $HOME/.ssh/b2g-rsa

mkdir -p $HOME/artifacts
mkdir -p $HOME/artifacts-public

mv $WORKSPACE/B2G/upload-public/b2g-flame-gecko-update.mar $HOME/artifacts-public/b2g-flame-gecko-update.mar
mv $WORKSPACE/B2G/upload/sources.xml $HOME/artifacts/sources.xml
#mv $WORKSPACE/B2G/upload/b2g-*.crashreporter-symbols.zip $HOME/artifacts/b2g-crashreporter-symbols.zip
mv $WORKSPACE/B2G/upload/b2g-*.android-arm.tar.gz $HOME/artifacts/b2g-android-arm.tar.gz
mv $WORKSPACE/B2G/upload/${TARGET}.zip $HOME/artifacts/${TARGET}.zip
mv $WORKSPACE/B2G/upload/gaia.zip $HOME/artifacts/gaia.zip
ccache -s
