class TerrainController {
  constructor({ terrainModel }) {
    this.terrainModel = terrainModel;
  }
  getAllTerrains = async (_req, res) => {
    try {
      const terrains = await this.terrainModel.getAllTerrains();
      if (!terrains) {
        res.status(404).send({ error: "Not found" });
      } else {
        res.status(200).send(terrains);
      }
    } catch (error) {
      console.log(error);
      res.status(500).json({ error });
    }
  };
  getTerrainById = async (req, res) => {
    try {
      const terrain = await this.terrainModel.getTerrainById({
        terrainId: parseInt(req.params.id),
      });
      if (!terrain) {
        res.status(404).send({ error: "Not found" });
      } else {
        res.status(200).send(terrain);
      }
    } catch (error) {
      console.error(error);
      res.status(500).send({ error: "Not found" });
    }
  };
  deleteTerreno = async (req, res) => {
    try {
      const Terrenos = await this.terrainModel.deleteTerreno(req.params.id);
      res.status(200).send(Terrenos);
    } catch (error) {
      console.log(error);
      res.status(500).json({ error });
    }
  };
  modifyTerrain = async (req, res) => {
    try {
      const terreno = await this.terrainModel.modifyTerrain(req.body);
      if (!terreno) {
        res.status(404).send({ error: "Not found" });
      } else {
        res.status(200).send(terreno);
      }
    } catch (error) {
      console.log(error);
      res.status(500).json({ error });
    }
  };
  addTerrain = async (req, res) => {
    try {
      const Terrenos = await this.terrainModel.addTerrain(req.body);
      if (!Terrenos) {
        res.status(404).send({ error: "Not found" });
      } else {
        res.status(200).send(Terrenos);
      }
    } catch (error) {
      console.log(error);
      res.status(500).json({ error });
    }
  };
}
module.exports = { TerrainController };
