#!/bin/bash
systemctl restart hysteria-server.service
systemctl enable --now hysteria-server.service
