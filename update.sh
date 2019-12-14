#!/bin/bash

if [[ ${1} == "screenshot" ]]; then
    SERVICE_IP="http://nzbget:tegbzn6789@$(dig +short service):6789"
    NETWORK_IDLE="2"
    cd /usr/src/app && node <<EOF
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    bindAddress: "0.0.0.0",
    args: [
      "--no-sandbox",
      "--headless",
      "--disable-gpu",
      "--disable-dev-shm-usage",
      "--remote-debugging-port=9222",
      "--remote-debugging-address=0.0.0.0"
    ]
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1920, height: 1080 });
  await page.goto("${SERVICE_IP}", { waitUntil: "networkidle${NETWORK_IDLE}" });
  await page.evaluate(() => {
    const div = document.createElement('div');
    div.innerHTML = '<h3 style="margin-top:0;">${DRONE_REPO_OWNER}/${DRONE_REPO_NAME##docker-}:${DRONE_COMMIT_BRANCH}</h3>Commit: ${DRONE_COMMIT_SHA:0:7}<br>Build: #${DRONE_BUILD_NUMBER}<br>Timestamp: $(date -u --iso-8601=seconds)';
    div.style.cssText = "all: initial; border-radius: 4px; font-weight: normal; font-size: normal; font-family: monospace; padding: 10px; color: black; position: fixed; bottom: 10px; right: 10px; background-color: #e7f3fe; border-left: 6px solid #2196F3; z-index: 10000";
    document.body.appendChild(div);
  });
  await page.screenshot({ path: "/drone/src/screenshot.png", fullPage: true });
  await browser.close();
})();
EOF
elif [[ ${1} == "checkservice" ]]; then
    SERVICE="http://nzbget:tegbzn6789@service:6789"
    currenttime=$(date +%s); maxtime=$((currenttime+60)); while (! curl -fsSL ${SERVICE} > /dev/null) && [[ "$currenttime" -lt "$maxtime" ]]; do sleep 1; currenttime=$(date +%s); done
    curl -fsSL ${SERVICE} > /dev/null
else
    version=$(curl -fsSL "https://api.github.com/repos/nzbget/nzbget/releases" | jq -r .[0].name | sed s/v//g)
    [[ -z ${version} ]] && exit
    find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG NZBGET_VERSION=.*$/ARG NZBGET_VERSION=${version}/g" {} \;
    find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG NZBGET_VERSION_SHORT=.*$/ARG NZBGET_VERSION_SHORT=${version//-testing/}/g" {} \;
    sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version//-testing/}}/g" .drone.yml
    echo "##[set-output name=version;]${version//-testing/}"
fi
