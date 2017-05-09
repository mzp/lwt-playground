FROM mzpi/bucklescript:1.7

WORKDIR /home/opam

RUN git clone https://github.com/ocaml/opam-repository.git && \
      opam update && \
      opam install -y merlin ocp-indent utop lwt && \
      rm -rf /home/opam/opam-repository

WORKDIR /work
