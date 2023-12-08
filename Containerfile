ARG FROM=quay.io/centos-bootc/fedora-bootc:eln

FROM registry.fedoraproject.org/fedora:39 AS builder
RUN dnf install -y rust git-core cargo glib2-devel openssl-devel ostree-devel && \
  git clone --depth 1 --branch source https://github.com/ondrejbudai/bootc.git && \
  cd bootc && \
  cargo build --release

FROM $FROM

COPY --from=builder /bootc/target/release/bootc /usr/bin/bootc
